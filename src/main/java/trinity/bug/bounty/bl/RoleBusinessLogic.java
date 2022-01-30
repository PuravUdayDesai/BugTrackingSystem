package trinity.bug.bounty.bl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import trinity.bug.bounty.ConnectionProvider;
import trinity.bug.bounty.models.RoleApplicationModel;
import trinity.bug.bounty.models.RoleCreateModel;

@Service
public class RoleBusinessLogic {

	public ResponseEntity<Void> createRole(@Valid RoleCreateModel roleModel) {
		if (roleModel == null) {
			return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
		}

		try {
			Connection c = ConnectionProvider.getConnection();
			PreparedStatement stmt = c.prepareCall("" + "INSERT INTO public.roles(\n"
					+ "							role_name, \n" + "							role_color, \n"
					+ "							role_description,\n" + "							organization_id\n"
					+ "						)\n" + "VALUES (?, ?, ?, ?) RETURNING role_id;\n" + "");
			stmt.setString(1, roleModel.getRoleName());
			stmt.setString(2, roleModel.getRoleColor());
			stmt.setString(3, roleModel.getRoleDescription());
			stmt.setLong(4, roleModel.getOrganizationId());

			ResultSet rs = stmt.executeQuery();
			long roleId = -1L;
			if (rs.next()) {
				roleId = rs.getLong("role_id");
			}

			if (roleId == -1) {
				c.commit();
				stmt.close();
				c.close();
				return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
			}
			c.commit();
			stmt.close();
			c.close();

			Iterator<RoleApplicationModel> listIterator = roleModel.getApplications().iterator();
			while (listIterator.hasNext()) {
				RoleApplicationModel model = listIterator.next();
				Connection c2 = ConnectionProvider.getConnection();
				PreparedStatement stmt2 = c2.prepareCall(""
						+ "INSERT INTO public.roles_application(\n"
						+ "										role_id, \n"
						+ "										application_id,\n"
						+ "										create_flag,\n"
						+ "										read_flag,\n"
						+ "										update_flag,\n"
						+ "										delete_flag\n"
						+ "									)\n"
						+ "VALUES (?, ?, ?, ?, ?, ?);");
				stmt2.setLong(1, roleId);
				stmt2.setLong(2, model.getApplicationId());
				stmt2.setBoolean(3, model.getCreate());
				stmt2.setBoolean(4, model.getRead());
				stmt2.setBoolean(5, model.getUpdate());
				stmt2.setBoolean(6, model.getDelete());
				
				int resultSub = stmt2.executeUpdate();
				if(resultSub == 0)
				{
					return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
				}
				
				c2.commit();
				stmt2.close();
				c2.close();
			}

		} catch (ClassNotFoundException e) {
			return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
		} catch (SQLException e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<Void>(HttpStatus.CREATED);
	}

}
