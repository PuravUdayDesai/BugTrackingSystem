package trinity.bug.bounty.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import trinity.bug.bounty.bl.OrganizationBusinessLogic;
import trinity.bug.bounty.models.OrganizationRegisterModel;
import trinity.bug.bounty.models.OrganizationResponseModel;

@RestController
@RequestMapping("/organization")
@CrossOrigin(origins = "*")
public class OrganizationController {
	
	@Autowired
	OrganizationBusinessLogic organizationBusinessLogic;
	
	@PostMapping(consumes = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE }, produces = {
			MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<Void> registerOrganization(@RequestBody @Valid OrganizationRegisterModel organizationRegisterModel)
	{
		return organizationBusinessLogic.registerOrganization(organizationRegisterModel);
	}
	
	@DeleteMapping(path = "/{organizationId}")
	public ResponseEntity<Void> deleteOrganization(@PathVariable Long organizationId)
	{
		return organizationBusinessLogic.deleteOrganization(organizationId);
	}
	
	@PutMapping(path = "/{organizationId}")
	public ResponseEntity<Void> recoverOrganization(@PathVariable Long organizationId)
	{
		return organizationBusinessLogic.recoverOrganization(organizationId);
	}

	@PutMapping(path = "/private/{organizationId}")
	public ResponseEntity<Void> makeOrganizationPrivate(@PathVariable Long organizationId)
	{
		return organizationBusinessLogic.makeOrganizationPrivate(organizationId);
	}
	
	@PutMapping(path = "/public/{organizationId}")
	public ResponseEntity<Void> makeOrganizationPublic(@PathVariable Long organizationId)
	{
		return organizationBusinessLogic.makeOrganizationPublic(organizationId);
	}

	@GetMapping(path = "/{userId}", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<List<OrganizationResponseModel>> getOrganizationListByUserId(@PathVariable Long userId) {
		return organizationBusinessLogic.getOrganizationListByUserId(userId);
	}
	
}
