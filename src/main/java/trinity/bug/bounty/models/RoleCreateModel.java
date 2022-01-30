package trinity.bug.bounty.models;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotNull;

public class RoleCreateModel implements Serializable {
	private static final long serialVersionUID = 1L;
	@NotNull(message = "Organization Id should not be empty")
	private Long organizationId;
	@NotNull(message = "Role Name should not be empty")
	private String roleName;
	@NotNull(message = "Role Color should not be empty")
	private String roleColor;
	@NotNull(message = "Role Description should not be empty")
	private String roleDescription;
	@NotNull(message = "Applications should not be empty")
	private List<RoleApplicationModel> applications;

	public RoleCreateModel() {
		super();
	}

	public RoleCreateModel(@NotNull(message = "Organization Id should not be empty") Long organizationId,
			@NotNull(message = "Role Name should not be empty") String roleName,
			@NotNull(message = "Role Color should not be empty") String roleColor,
			@NotNull(message = "Role Description should not be empty") String roleDescription,
			@NotNull(message = "Applications should not be empty") List<RoleApplicationModel> applications) {
		super();
		this.organizationId = organizationId;
		this.roleName = roleName;
		this.roleColor = roleColor;
		this.roleDescription = roleDescription;
		this.applications = applications;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getRoleColor() {
		return roleColor;
	}

	public void setRoleColor(String roleColor) {
		this.roleColor = roleColor;
	}

	public String getRoleDescription() {
		return roleDescription;
	}

	public void setRoleDescription(String roleDescription) {
		this.roleDescription = roleDescription;
	}

	public List<RoleApplicationModel> getApplications() {
		return applications;
	}

	public void setApplications(List<RoleApplicationModel> applications) {
		this.applications = applications;
	}

	public Long getOrganizationId() {
		return organizationId;
	}

	public void setOrganizationId(Long organizationId) {
		this.organizationId = organizationId;
	}

}
