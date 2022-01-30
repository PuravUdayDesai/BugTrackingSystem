package trinity.bug.bounty.bl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import trinity.bug.bounty.ConnectionProvider;
import trinity.bug.bounty.models.ApplicationRegisterModel;
import trinity.bug.bounty.models.ApplicationResponseModel;

@Service
public class ApplicationBusinessLogic {

	public ResponseEntity<Void> registerApplication(ApplicationRegisterModel applicationRegisterModel) {
		if (applicationRegisterModel == null) {
			return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
		}

		try {
			Connection c = ConnectionProvider.getConnection();
			PreparedStatement stmt = c.prepareCall(
					"INSERT INTO public.application(application_name, application_description, organization_id, mark_for_private) VALUES (?, ?, ?, ? );");
			stmt.setString(1, applicationRegisterModel.getApplicationName());
			stmt.setString(2, applicationRegisterModel.getApplicationDescription());
			stmt.setLong(3, applicationRegisterModel.getOrganizationId());
			stmt.setBoolean(4, applicationRegisterModel.getMarkForPrivate());

			int insertFlag = stmt.executeUpdate();
			if (insertFlag == 0) {
				c.commit();
				stmt.close();
				c.close();
				return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
			}
			c.commit();
			stmt.close();
			c.close();

		} catch (ClassNotFoundException e) {
			return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
		} catch (SQLException e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<Void>(HttpStatus.CREATED);
	}

	public ResponseEntity<Void> deleteApplication(Long applicationId) {
		if (applicationId == null) {
			return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
		}

		try {
			Connection c = ConnectionProvider.getConnection();
			PreparedStatement stmt = c
					.prepareCall("UPDATE public.application SET mark_for_delete = TRUE WHERE application_id = ?");
			stmt.setLong(1, applicationId);

			int result = stmt.executeUpdate();
			if (result == 0) {
				c.commit();
				stmt.close();
				c.close();
				return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
			}

			c.commit();
			stmt.close();
			c.close();

		} catch (ClassNotFoundException e) {
			return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
		} catch (SQLException e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<Void>(HttpStatus.OK);
	}

	public ResponseEntity<Void> recoverApplication(Long applicationId) {
		if (applicationId == null) {
			return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
		}

		try {
			Connection c = ConnectionProvider.getConnection();
			PreparedStatement stmt = c
					.prepareCall("UPDATE public.application SET mark_for_delete = FALSE WHERE application_id = ?");
			stmt.setLong(1, applicationId);

			int result = stmt.executeUpdate();
			if (result == 0) {
				c.commit();
				stmt.close();
				c.close();
				return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
			}

			c.commit();
			stmt.close();
			c.close();

		} catch (ClassNotFoundException e) {
			return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
		} catch (SQLException e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<Void>(HttpStatus.OK);
	}

	public ResponseEntity<Void> makeApplicationPrivate(Long applicationId) {
		if (applicationId == null) {
			return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
		}

		try {
			Connection c = ConnectionProvider.getConnection();
			PreparedStatement stmt = c
					.prepareCall("UPDATE public.application SET mark_for_private = TRUE WHERE application_id = ?");
			stmt.setLong(1, applicationId);

			int result = stmt.executeUpdate();
			if (result == 0) {
				c.commit();
				stmt.close();
				c.close();
				return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
			}

			c.commit();
			stmt.close();
			c.close();

		} catch (ClassNotFoundException e) {
			return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
		} catch (SQLException e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<Void>(HttpStatus.OK);
	}

	public ResponseEntity<Void> makeApplicationPublic(Long applicationId) {
		if (applicationId == null) {
			return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
		}

		try {
			Connection c = ConnectionProvider.getConnection();
			PreparedStatement stmt = c
					.prepareCall("UPDATE public.application SET mark_for_private = FALSE WHERE application_id = ?");
			stmt.setLong(1, applicationId);

			int result = stmt.executeUpdate();
			if (result == 0) {
				c.commit();
				stmt.close();
				c.close();
				return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
			}

			c.commit();
			stmt.close();
			c.close();

		} catch (ClassNotFoundException e) {
			return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
		} catch (SQLException e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<Void>(HttpStatus.OK);
	}

	public ResponseEntity<List<ApplicationResponseModel>> getApplicationListByUserId(Long userId) {
		if (userId == null) {
			return new ResponseEntity<List<ApplicationResponseModel>>((List<ApplicationResponseModel>) null, HttpStatus.BAD_REQUEST);
		}
		List<ApplicationResponseModel> list = new ArrayList<ApplicationResponseModel>();
		try {
			Connection c = ConnectionProvider.getConnection();
			PreparedStatement stmt = c.prepareCall(""
					+ "SELECT 	application_id, \n"
					+ "		application_name,\n"
					+ "		organization_id,\n"
					+ "		application_description,\n"
					+ "		created_on,\n"
					+ "		mark_for_private\n"
					+ "FROM public.application\n"
					+ "WHERE organization_id IN (\n"
					+ "							SELECT organization_id \n"
					+ "							FROM public.organization\n"
					+ "							WHERE mark_for_delete = FALSE\n"
					+ "							AND created_by = ?)\n"
					+ "AND mark_for_delete = FALSE;\n"
					+ "");
			stmt.setLong(1, userId);
			
			ResultSet rs = stmt.executeQuery();
			while(rs.next())
			{
				ApplicationResponseModel model = new ApplicationResponseModel();
				model.setApplicationDescription(rs.getString("application_description"));
				model.setApplicationId(rs.getLong("application_id"));
				model.setApplicationName(rs.getString("application_name"));
				model.setOrganizationId(rs.getLong("organization_id"));
				model.setCreatedOn(rs.getTimestamp("created_on"));
				model.setMarkForPrivate(rs.getBoolean("mark_for_private"));
				list.add(model);
			}
			
			if (list.size() == 0) {
				c.commit();
				stmt.close();
				c.close();
				return new ResponseEntity<List<ApplicationResponseModel>>((List<ApplicationResponseModel>) null, HttpStatus.NO_CONTENT);
			}

			c.commit();
			stmt.close();
			c.close();

		} catch (ClassNotFoundException e) {
			return new ResponseEntity<List<ApplicationResponseModel>>((List<ApplicationResponseModel>) null, HttpStatus.NOT_FOUND);
		} catch (SQLException e) {
			return new ResponseEntity<List<ApplicationResponseModel>>((List<ApplicationResponseModel>) null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<List<ApplicationResponseModel>>(list, HttpStatus.OK);
	}

}
