package trinity.bug.bounty.models;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

public class OrganizationRegisterModel implements Serializable {
	private static final long serialVersionUID = 1L;
	@NotNull(message = "Organization Name should not be empty")
	private String organizationName;
	@NotNull(message = "Organization Description should not be empty")
	private String organizationDescription;
	@NotNull(message = "Organization Website should not be empty")
	private String organizationWebsite;
	@NotNull(message = "User Id should not be empty")
	private Long userId;
	@NotNull(message = "Mark For Private should not be empty")
	private Boolean markForPrivate;
	
	public OrganizationRegisterModel() {
		super();
	}
	
	public OrganizationRegisterModel(
			@NotNull(message = "Organization Name should not be empty") String organizationName,
			@NotNull(message = "Organization Description should not be empty") String organizationDescription,
			@NotNull(message = "Organization Website should not be empty") String organizationWebsite,
			@NotNull(message = "User Id should not be empty") Long userId,
			@NotNull(message = "Mark For Private should not be empty") Boolean markForPrivate) {
		super();
		this.organizationName = organizationName;
		this.organizationDescription = organizationDescription;
		this.organizationWebsite = organizationWebsite;
		this.userId = userId;
		this.markForPrivate = markForPrivate;
	}
	
	public String getOrganizationName() {
		return organizationName;
	}

	public void setOrganizationName(String organizationName) {
		this.organizationName = organizationName;
	}

	public String getOrganizationDescription() {
		return organizationDescription;
	}

	public void setOrganizationDescription(String organizationDescription) {
		this.organizationDescription = organizationDescription;
	}

	public String getOrganizationWebsite() {
		return organizationWebsite;
	}

	public void setOrganizationWebsite(String organizationWebsite) {
		this.organizationWebsite = organizationWebsite;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Boolean getMarkForPrivate() {
		return markForPrivate;
	}

	public void setMarkForPrivate(Boolean markForPrivate) {
		this.markForPrivate = markForPrivate;
	}
}
