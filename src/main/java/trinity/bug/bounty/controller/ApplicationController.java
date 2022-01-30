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

import trinity.bug.bounty.bl.ApplicationBusinessLogic;
import trinity.bug.bounty.models.ApplicationRegisterModel;
import trinity.bug.bounty.models.ApplicationResponseModel;

@RestController
@RequestMapping("/application")
@CrossOrigin(origins = "*")
public class ApplicationController {
	@Autowired
	ApplicationBusinessLogic applicationBusinessLogic;

	@PostMapping(consumes = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE }, produces = {
			MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<Void> registerApplication(
			@RequestBody @Valid ApplicationRegisterModel applicationRegisterModel) {
		return applicationBusinessLogic.registerApplication(applicationRegisterModel);
	}

	@DeleteMapping(path = "/{applicationId}")
	public ResponseEntity<Void> deleteApplication(@PathVariable Long applicationId) {
		return applicationBusinessLogic.deleteApplication(applicationId);
	}

	@PutMapping(path = "/{applicationId}")
	public ResponseEntity<Void> recoverApplication(@PathVariable Long applicationId) {
		return applicationBusinessLogic.recoverApplication(applicationId);
	}

	@PutMapping(path = "/private/{applicationId}")
	public ResponseEntity<Void> makeApplicationPrivate(@PathVariable Long applicationId) {
		return applicationBusinessLogic.makeApplicationPrivate(applicationId);
	}

	@PutMapping(path = "/public/{applicationId}")
	public ResponseEntity<Void> makeApplicationPublic(@PathVariable Long applicationId) {
		return applicationBusinessLogic.makeApplicationPublic(applicationId);
	}

	@GetMapping(path = "/{userId}", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<List<ApplicationResponseModel>> getApplicationListByUserId(@PathVariable Long userId) {
		return applicationBusinessLogic.getApplicationListByUserId(userId);
	}
}
