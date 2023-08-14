package com.bitc.aop;

import java.util.Arrays;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Aspect
@Component
@Slf4j
public class AOPAdvice {
	
	public AOPAdvice() {
		System.out.println("AOP Advice 생성");
	}
	// target joinPoint(method) 가 실행되기 전 호출
	@Before("execution(* com.bitc.service.*.*(..))")
	public void startLog(JoinPoint jp) {
		log.info("---------------------------------");
		log.info("---------------------------------");
		log.info("---------- START LOG ------------");
		log.info("target : "+jp.getTarget());
		log.info("type : "+jp.getKind());
		log.info("parameters : " + Arrays.toString(jp.getArgs()));
		log.info("name : " + jp.getSignature().getName());
		log.info("---------- START LOG END --------");
		log.info("---------------------------------");
		log.info("---------------------------------");
	}
	
	@After("execution(* com.bitc.service.MessageService*.*(..))")
	public void endLog(JoinPoint jp) {
		log.info("----------- END AFTER LOG --------------");
		log.info("----------------------------------------");
	}
	
	@AfterReturning(
		pointcut="execution(!void com.bitc.service.MessageServiceImpl.*(..))",
		returning = "returnValue")
	public void successLog(JoinPoint jp, Object returnValue) {
		log.info("---------------------------------------------");
		log.info("---------- START Afterreturning LOG -------------");
		log.info("target : " + jp.getTarget());
		log.info("name : " + jp.getSignature().getName());
		log.info("returns : " + returnValue);
		log.info("---------- END Afterreturning LOG -------------");
		log.info("---------------------------------------------");
	}
	
	@AfterThrowing(
		value = "execution(* com.bitc.service.*.*(..))",
		throwing = "exception"
	)
	public void endThrowing(JoinPoint jp, Exception exception) {
		log.info("---------------------------------------------");
		log.info("---------- START @AfterThrowing LOG -------------");
		log.info("target : " + jp.getTarget());
		log.info("name : " + jp.getSignature().getName());
		log.warn("error : " + exception.getMessage());
		log.info("---------- END @AfterThrowing LOG -------------");
		log.info("---------------------------------------------");
	}
	
	@Around(value="execution(* com.bitc.service.MessageServiceImpl.readMessage(String,int)) && args(uid,mno)")
	public Object readMessageLog(ProceedingJoinPoint pjp, String uid, int mno)
			throws Throwable {
		log.info("--------------------------------");
		log.info("------- AROUND START--------");
		log.info("param uid : " + uid);
		log.info("param mno : " + mno);
		log.info("target : "+pjp.getTarget());
		log.info("type : "+pjp.getKind());
		log.info("parameters : " + Arrays.toString(pjp.getArgs()));
		log.info("name : " + pjp.getSignature().getName());
		// pointcut method 실행
		Object o = pjp.proceed();
		log.info("around : " + o.toString());
		log.info("-------------  AROUND END --------------------");
		log.info("----------------------------------------------");
		return o;
	};
	
	
	
}













