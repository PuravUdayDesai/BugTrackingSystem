package trinity.bug.bounty.models;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ApplicationResponseModel implements Serializable {
	private static final long serialVersionUID = 1L;
	@NotNull(message = "Application Id should not be empty")
	private Long applicationId;
	@NotNull(message = "Organization Id should not be empty")
	private Long organizationId;
	@NotNull(message = "Application Name should not be empty")
	private String applicationName;
	@NotNull(message = "Application Name should not be empty")
	private String applicationDescription;
	@NotNull(message = "Created On should not be empty")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "IST")
	private Timestamp createdOn;
	@NotNull(message = "Mark For Private should not be empty")
	private Boolean markForPrivate;

	public ApplicationResponseModel() {
		super();
	}

	public ApplicationResponseModel(@NotNull(message = "Application Id should not be empty") Long applicationId,
			@NotNull(message = "Organization Id should not be empty") Long organizationId,
			@NotNull(message = "Application Name should not be empty") String applicationName,
			@NotNull(message = "Application Name should not be empty") String applicationDescription,
			@NotNull(message = "Created On should not be empty") Timestamp createdOn,
			@NotNull(message = "Mark For Private should not be empty") Boolean markForPrivate) {
		super();
		this.applicationId = applicationId;
		this.organizationId = organizationId;
		this.applicationName = applicationName;
		this.applicationDescription = applicationDescription;
		this.createdOn = createdOn;
		this.markForPrivate = markForPrivate;
	}

	public Long getOrganizationId() {
		return organizationId;
	}

	public void setOrganizationId(Long organizationId) {
		this.organizationId = organizationId;
	}

	public Long getApplicationId() {
		return applicationId;
	}

	public void setApplicationId(Long applicationId) {
		this.applicationId = applicationId;
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

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}

	public Boolean getMarkForPrivate() {
		return markForPrivate;
	}

	public void setMarkForPrivate(Boolean markForPrivate) {
		this.markForPrivate = markForPrivate;
	}
}
