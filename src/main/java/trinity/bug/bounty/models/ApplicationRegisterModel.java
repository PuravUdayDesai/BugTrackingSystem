package trinity.bug.bounty.models;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

public class ApplicationRegisterModel implements Serializable {

	private static final long serialVersionUID = 1L;
	@NotNull(message = "Application Name should not be empty")
	private String applicationName;
	@NotNull(message = "Application Description should not be empty")
	private String applicationDescription;
	@NotNull(message = "Organization Id should not be empty")
	private Long organizationId;
	@NotNull(message = "Mark For Private should not be empty")
	private Boolean markForPrivate;

	public ApplicationRegisterModel() {
		super();
	}

	public ApplicationRegisterModel(@NotNull(message = "Application Name should not be empty") String applicationName,
			@NotNull(message = "Application Description should not be empty") String applicationDescription,
			@NotNull(message = "Organization Id should not be empty") Long organizationId,
			@NotNull(message = "Mark For Private should not be empty") Boolean markForPrivate) {
		super();
		this.applicationName = applicationName;
		this.applicationDescription = applicationDescription;
		this.organizationId = organizationId;
		this.markForPrivate = markForPrivate;
	}

	public String getApplicationName() {
		return applicationName;
	}

	public void setApplicationName(String applicationName) {
		this.applicationName = applicationName;
	}

	public String getApplicationDescription() {
		return applicationDescription;
	}

	public void setApplicationDescription(String applicationDescription) {
		this.applicationDescription = applicationDescription;
	}

	public Long getOrganizationId() {
		return organizationId;
	}

	public void setOrganizationId(Long organizationId) {
		this.organizationId = organizationId;
	}

	public Boolean getMarkForPrivate() {
		return markForPrivate;
	}

	public void setMarkForPrivate(Boolean markForPrivate) {
		this.markForPrivate = markForPrivate;
	}
}
