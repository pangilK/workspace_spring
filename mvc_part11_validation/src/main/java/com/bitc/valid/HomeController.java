package com.bitc.valid;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import javax.annotation.PostConstruct;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequiredArgsConstructor
public class HomeController {
	
	private final JavaMailSender mailSender;
	
    private DefaultMessageService messageService;
    
    @PostConstruct
    public void init() {
        // 반드시 계정 내 등록된 유효한 API 키, API Secret Key를 입력해주셔야 합니다!
        this.messageService = NurigoApp.INSTANCE.initialize("NCSJTRMPWKIOOYGY", "8ENTA6TFUIGRXHFHH7EEGW1SNAMZM2SJ", "https://api.coolsms.co.kr");
    }
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "home";
	}
	
	@GetMapping("/user/join")
	public void join() {}
	
	@GetMapping("/user/uidCheck")
	@ResponseBody
	public boolean isCheck(String u_id) {
		System.out.println("u_id : " + u_id);
		if(u_id != null && !u_id.equals("pak_stella@naver.com")) {
			// 등록 되지 않은 이메일
			return true;
		}
		return false;
	}
	
	@GetMapping("/checkEmail")
	@ResponseBody
	public String sendMail(@RequestParam("u_id") String email) throws Exception{
		String code = "";
		for(int i = 0 ; i < 5 ; i++) {
			code += new Random().nextInt(10);
		}
		System.out.println(code);
		MimeMessage msg = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(msg,"UTF-8");
		helper.setFrom("woawoa9012@gmail.com","MASTER_KPG");
		helper.setTo(email);
		helper.setSubject("이메일 인증코드를 확인");
		helper.setText("다음 인증 코드를 입력해 주세요<h3>["+code+"]</h3>",true);
		mailSender.send(msg);
		System.out.println(code+"전송 완료");
		return code;
	}
	
	@GetMapping("/user/login")
	public void login() {}
	
	// 전화 문자 인증 코드 발송
	@PostMapping("sendSMS")
	@ResponseBody
	public Map<String, String> sendSMS(@RequestParam String userPhoneNumber){
		Map<String, String> map = new HashMap<>();
		
		String code = "";
		for(int i = 0 ; i < 5 ; i++) {
			code += new Random().nextInt(10);
		}
		// net.nurigo....
		Message message = new Message();
		message.setFrom("01023619020");
		message.setTo(userPhoneNumber);
		message.setText("K에서 전송한 메세지 ["+code+"] 코드를 확인후 입력해주세요.");
		SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
		System.out.println(response);
		map.put("code", code);
		// statusCode == 2000 정상 발신
		map.put("result", response.getStatusCode());
		return map;
	}
	
	
}
