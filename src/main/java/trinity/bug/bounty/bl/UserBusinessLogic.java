package trinity.bug.bounty.bl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import trinity.bug.bounty.ConnectionProvider;
import trinity.bug.bounty.models.UserLoginModel;
import trinity.bug.bounty.models.UserLoginResponseModel;
import trinity.bug.bounty.models.UserRegisterModel;

@Service
public class UserBusinessLogic {
	public ResponseEntity<Void> registerUser(UserRegisterModel userRegisterModel) {
		if (userRegisterModel == null) {
			return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
		}

		try {
			Connection c = ConnectionProvider.getConnection();
			PreparedStatement stmt = c.prepareCall(
					"INSERT INTO public.\"user\"(user_name, user_emailid, user_contact, user_country, user_password) VALUES (?, ?, ?, ?, ?);");
			stmt.setString(1, userRegisterModel.getUserName());
			stmt.setString(2, userRegisterModel.getUserEmailId());
			stmt.setString(3, userRegisterModel.getUserContactNumber());
			stmt.setString(4, userRegisterModel.getUserCountry());
			stmt.setString(5, userRegisterModel.getUserPassword());

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

	public ResponseEntity<UserLoginResponseModel> loginUser(UserLoginModel userLoginModel) {
		if (userLoginModel == null) {
			return new ResponseEntity<UserLoginResponseModel>((UserLoginResponseModel) null, HttpStatus.BAD_REQUEST);
		}
		
		UserLoginResponseModel userLoginResponseModel = null;
		
		try {
			Connection c = ConnectionProvider.getConnection();
			PreparedStatement stmt = c.prepareCall(
					"SELECT user_id, user_name, user_emailid, user_country FROM public.\"user\" WHERE mark_for_delete = false AND user_contact = ? AND user_password = ?;");
			stmt.setString(1, userLoginModel.getUserContactNumber());
			stmt.setString(2, userLoginModel.getUserPassword());

			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				userLoginResponseModel = new UserLoginResponseModel();
				userLoginResponseModel.setUserId(rs.getLong("user_id"));
				userLoginResponseModel.setUserName(rs.getString("user_name"));
				userLoginResponseModel.setUserEmailId(rs.getString("user_emailid"));
				userLoginResponseModel.setUserCountry(rs.getString("user_country"));
			} else {
				stmt.close();
				c.close();
				return new ResponseEntity<UserLoginResponseModel>((UserLoginResponseModel) null, HttpStatus.BAD_REQUEST);
			}
			
			stmt.close();
			c.close();

		} catch (ClassNotFoundException e) {
			return new ResponseEntity<UserLoginResponseModel>((UserLoginResponseModel) null,HttpStatus.NOT_FOUND);
		} catch (SQLException e) {
			return new ResponseEntity<UserLoginResponseModel>((UserLoginResponseModel) null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return new ResponseEntity<UserLoginResponseModel>(userLoginResponseModel, HttpStatus.OK);
	}
}
