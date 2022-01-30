package trinity.bug.bounty.controller;

import javax.mail.MessagingException;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import trinity.bug.bounty.bl.UserBusinessLogic;
import trinity.bug.bounty.models.UserLoginModel;
import trinity.bug.bounty.models.UserLoginResponseModel;
import trinity.bug.bounty.models.UserRegisterModel;

@RestController
@RequestMapping("/user")
@CrossOrigin(origins = "*")
public class UserController 
{
	@Autowired
	UserBusinessLogic userBusinessLogic;
	
	@PostMapping(consumes = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE }, produces = {
			MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<Void> registerUser(@RequestBody @Valid UserRegisterModel userRegisterModel) throws MessagingException
	{
		return userBusinessLogic.registerUser(userRegisterModel);
	}
	
	@PostMapping(path="/login", consumes = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE }, produces = {
			MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<UserLoginResponseModel> loginUser(@RequestBody @Valid UserLoginModel userLoginModel)
	{
		return userBusinessLogic.loginUser(userLoginModel);
	}
	
	
}	
