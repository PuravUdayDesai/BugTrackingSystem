package trinity.bug.bounty.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import trinity.bug.bounty.bl.RoleBusinessLogic;
import trinity.bug.bounty.models.RoleCreateModel;

@RestController
@RequestMapping("/role")
@CrossOrigin(origins = "*")
public class RoleController {

	@Autowired
	RoleBusinessLogic roleBusinessLogic;

	@PostMapping(consumes = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE }, produces = {
			MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<Void> createRole(@RequestBody @Valid RoleCreateModel roleModel) {
		return roleBusinessLogic.createRole(roleModel);
	}

}
