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
import trinity.bug.bounty.models.OrganizationRegisterModel;
import trinity.bug.bounty.models.OrganizationResponseModel;

@Service
public class OrganizationBusinessLogic {

	public ResponseEntity<Void> registerOrganization(OrganizationRegisterModel organizationRegisterModel) {
		if (organizationRegisterModel == null) {
			return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
		}

		try {
			Connection c = ConnectionProvider.getConnection();
			PreparedStatement stmt = c.prepareCall("INSERT INTO public.organization	(\n"
					+ "									organization_name, \n"
					+ "									organization_description, \n"
					+ "									organization_weblink, \n"
					+ "									created_by, \n"
					+ "									mark_for_private\n" + "								)\n"
					+ "VALUES (?, ?, ?, ?, ?);");
			stmt.setString(1, organizationRegisterModel.getOrganizationName());
			stmt.setString(2, organizationRegisterModel.getOrganizationDescription());
			stmt.setString(3, organizationRegisterModel.getOrganizationWebsite());
			stmt.setLong(4, organizationRegisterModel.getUserId());;
			stmt.setBoolean(5, organizationRegisterModel.getMarkForPrivate());

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
			e.printStackTrace();
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<Void>(HttpStatus.CREATED);
	}

	public ResponseEntity<Void> deleteOrganization(Long organizationId) {
		if (organizationId == null) {
			return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
		}

		try {
			Connection c = ConnectionProvider.getConnection();
			PreparedStatement stmt = c
					.prepareCall("UPDATE public.organization SET mark_for_delete = TRUE WHERE organization_id = ?");
			stmt.setLong(1, organizationId);

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

	public ResponseEntity<Void> recoverOrganization(Long organizationId) {
		if (organizationId == null) {
			return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
		}

		try {
			Connection c = ConnectionProvider.getConnection();
			PreparedStatement stmt = c
					.prepareCall("UPDATE public.organization SET mark_for_delete = FALSE WHERE organization_id = ?");
			stmt.setLong(1, organizationId);

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

	
	
	public ResponseEntity<Void> makeOrganizationPrivate(Long organizationId) {
		if (organizationId == null) {
			return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
		}

		try {
			Connection c = ConnectionProvider.getConnection();
			PreparedStatement stmt = c
					.prepareCall("UPDATE public.organization SET mark_for_private = TRUE WHERE organization_id = ?");
			stmt.setLong(1, organizationId);

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

	public ResponseEntity<Void> makeOrganizationPublic(Long organizationId) {
		if (organizationId == null) {
			return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
		}

		try {
			Connection c = ConnectionProvider.getConnection();
			PreparedStatement stmt = c
					.prepareCall("UPDATE public.organization SET mark_for_private = FALSE WHERE organization_id = ?");
			stmt.setLong(1, organizationId);

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

	public ResponseEntity<List<OrganizationResponseModel>> getOrganizationListByUserId(Long userId) {
		if (userId == null) {
			return new ResponseEntity<List<OrganizationResponseModel>>((List<OrganizationResponseModel>) null, HttpStatus.BAD_REQUEST);
		}
		List<OrganizationResponseModel> list = new ArrayList<OrganizationResponseModel>();
		try {
			Connection c = ConnectionProvider.getConnection();
			PreparedStatement stmt = c.prepareCall(""
					+ "SELECT 	organization_id,\n"
					+ "		organization_name,\n"
					+ "		organization_description, \n"
					+ "		organization_weblink,\n"
					+ "		created_on, \n"
					+ "		mark_for_private, \n"
					+ "		created_by\n"
					+ "FROM public.organization\n"
					+ "WHERE created_by = ?\n"
					+ "AND mark_for_delete = FALSE;");
			stmt.setLong(1, userId);
			
			ResultSet rs = stmt.executeQuery();
			while(rs.next())
			{
				OrganizationResponseModel model = new OrganizationResponseModel();
				model.setCreatedOn(rs.getTimestamp("created_on"));
				model.setMarkForPrivate(rs.getBoolean("mark_for_private"));
				model.setOrganizationDescription(rs.getString("organization_description"));
				model.setOrganizationId(rs.getLong("organization_id"));
				model.setOrganizationName(rs.getString("organization_name"));
				model.setOrganizationWebsite(rs.getString("organization_weblink"));
				model.setUserId(rs.getLong("created_by"));
				list.add(model);
			}
			
			if (list.size() == 0) {
				c.commit();
				stmt.close();
				c.close();
				return new ResponseEntity<List<OrganizationResponseModel>>((List<OrganizationResponseModel>) null, HttpStatus.NO_CONTENT);
			}

			c.commit();
			stmt.close();
			c.close();

		} catch (ClassNotFoundException e) {
			return new ResponseEntity<List<OrganizationResponseModel>>((List<OrganizationResponseModel>) null, HttpStatus.NOT_FOUND);
		} catch (SQLException e) {
			return new ResponseEntity<List<OrganizationResponseModel>>((List<OrganizationResponseModel>) null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<List<OrganizationResponseModel>>(list, HttpStatus.OK);
	}

	
	
}
