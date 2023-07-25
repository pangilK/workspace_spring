package com.bitc.di.vo;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
// @Component
@Service  			// 의미에 맞지 않게 사용하는것 좋지 않다.
public class TestBoardVO {
	
	private int num;
	private String title;
	private String content;
	
}
