package trinity.bug.bounty.models;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

public class UserLoginResponseModel implements Serializable {

	private static final long serialVersionUID = 1L;
	@NotNull(message = "User Id should not be empty")
	private Long userId;
	@NotNull(message = "User Name should not be empty")
	private String userName;
	@NotNull(message = "User EmailId should not be empty")
	private String userEmailId;
	@NotNull(message = "User Country should not be empty")
	private String userCountry;
	
	public UserLoginResponseModel() {
		super();
	}

	public UserLoginResponseModel(@NotNull(message = "User Id should not be empty") Long userId,
			@NotNull(message = "User Name should not be empty") String userName,
			@NotNull(message = "User EmailId should not be empty") String userEmailId,
			@NotNull(message = "User Country should not be empty") String userCountry) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.userEmailId = userEmailId;
		this.userCountry = userCountry;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
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

	public String getUserCountry() {
		return userCountry;
	}

	public void setUserCountry(String userCountry) {
		this.userCountry = userCountry;
	}

}
