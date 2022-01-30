package trinity.bug.bounty.models;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

public class RoleCreateModel implements Serializable
{
	private static final long serialVersionUID = 1L;
	@NotNull(message = "Role Name should not be empty")
	private String roleName;
	@NotNull(message = "Role Color should not be empty")
	private String roleColor;
	@NotNull(message = "Role Description should not be empty")
	private String roleDescription;

}
