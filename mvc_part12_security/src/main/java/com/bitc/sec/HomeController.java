package com.bitc.sec;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "home";
	}
	
	@GetMapping("login")
	public String login() {
		return "user/login";
	}
	
	@GetMapping("logout")
	public String logout() {
		return "user/logout";
	}
	
	@GetMapping("errorForbiden")
	public void errorForbiden() {}
	
	@GetMapping("logOff")
	public void logOff() {}
}
