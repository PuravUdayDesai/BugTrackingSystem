package trinity.bug.bounty.models;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

public class RoleApplicationModel implements Serializable {
	private static final long serialVersionUID = 1L;
	@NotNull(message = "Application Id should not be empty")
	private Long applicationId;
	@NotNull(message = "Create should not be empty")
	private Boolean create;
	@NotNull(message = "Read should not be empty")
	private Boolean read;
	@NotNull(message = "Update should not be empty")
	private Boolean update;
	@NotNull(message = "Delete should not be empty")
	private Boolean delete;

	public RoleApplicationModel() {
		super();
	}

	public RoleApplicationModel(@NotNull(message = "Application Id should not be empty") Long applicationId,
			@NotNull(message = "Create should not be empty") Boolean create,
			@NotNull(message = "Read should not be empty") Boolean read,
			@NotNull(message = "Update should not be empty") Boolean update,
			@NotNull(message = "Delete should not be empty") Boolean delete) {
		super();
		this.applicationId = applicationId;
		this.create = create;
		this.read = read;
		this.update = update;
		this.delete = delete;
	}

	public Long getApplicationId() {
		return applicationId;
	}

	public void setApplicationId(Long applicationId) {
		this.applicationId = applicationId;
	}

	public Boolean getCreate() {
		return create;
	}

	public void setCreate(Boolean create) {
		this.create = create;
	}

	public Boolean getRead() {
		return read;
	}

	public void setRead(Boolean read) {
		this.read = read;
	}

	public Boolean getUpdate() {
		return update;
	}

	public void setUpdate(Boolean update) {
		this.update = update;
	}

	public Boolean getDelete() {
		return delete;
	}

	public void setDelete(Boolean delete) {
		this.delete = delete;
	}

}
