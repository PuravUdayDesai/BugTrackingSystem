package trinity.bug.bounty.models;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

public class UserLoginModel implements Serializable
{
	private static final long serialVersionUID = 1L;
	@NotNull(message = "User Contact Number should not be empty")
	private String userContactNumber;
	@NotNull(message = "User Password should not be empty")
	private String userPassword;
	
	public UserLoginModel() {
		super();
	}

	public UserLoginModel(@NotNull(message = "User Contact Number should not be empty") String userContactNumber,
			@NotNull(message = "User Password should not be empty") String userPassword) {
		super();
		this.userContactNumber = userContactNumber;
		this.userPassword = userPassword;
	}

	public String getUserContactNumber() {
		return userContactNumber;
	}

	public void setUserContactNumber(String userContactNumber) {
		this.userContactNumber = userContactNumber;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	
}
