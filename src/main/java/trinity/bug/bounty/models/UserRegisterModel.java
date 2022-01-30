package trinity.bug.bounty.models;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

public class UserRegisterModel implements Serializable
{
	private static final long serialVersionUID = 1L;
	@NotNull(message = "User Name should not be empty")
	private String userName;
	@NotNull(message = "User EmailId should not be empty")
	private String userEmailId;
	@NotNull(message = "User Contact Number should not be empty")
	private String userContactNumber;
	@NotNull(message = "User Country should not be empty")
	private String userCountry;
	@NotNull(message = "User Password should not be empty")
	private String userPassword;

	
	public UserRegisterModel() {
		super();
	}

	public UserRegisterModel(@NotNull(message = "User Name should not be empty") String userName,
			@NotNull(message = "User EmailId should not be empty") String userEmailId,
			@NotNull(message = "User Contact Number should not be empty") String userContactNumber,
			@NotNull(message = "User Country should not be empty") String userCountry,
			@NotNull(message = "User Password should not be empty") String userPassword) {
		super();
		this.userName = userName;
		this.userEmailId = userEmailId;
		this.userContactNumber = userContactNumber;
		this.userCountry = userCountry;
		this.userPassword = userPassword;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserEmailId() {
		return userEmailId;
	}

	public void setUserEmailId(String userEmailId) {
		this.userEmailId = userEmailId;
	}

	public String getUserContactNumber() {
		return userContactNumber;
	}

	public void setUserContactNumber(String userContactNumber) {
		this.userContactNumber = userContactNumber;
	}

	public String getUserCountry() {
		return userCountry;
	}

	public void setUserCountry(String userCountry) {
		this.userCountry = userCountry;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
}
