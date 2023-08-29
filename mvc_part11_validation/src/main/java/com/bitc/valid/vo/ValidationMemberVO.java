package com.bitc.valid.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ValidationMemberVO {
	
	private int u_no;					// 회원번호
	private String u_id;				// 회원아이디(email)
	private String u_pw;				// 비밀번호
	private String u_profile;			// 프로필 이미지
	private String u_phone;				// 전화번호
	private String u_birth;				// 생년월일(19820607)
	private String u_addr;				// 주소
	private String u_addr_detail;		// 상세 주소
	private String u_addr_post;			// 우편번호
	private int u_point;				// 포인트
	private String u_info;				// 개인 정보 이용 동의
	private Date u_date;				// 계정 생성일
	private Date u_visi_date; 			// 최종 방문일(마지막 로그인)
	private String u_withdraw;			// 회원 정보 숨김(탈퇴)
	
}






