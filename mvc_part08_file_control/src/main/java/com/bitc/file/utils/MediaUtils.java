package com.bitc.file.utils;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

/**
 * 확장자를 이용하여 
 * Image File type을 MediaType으로 구분할 객체
 */
public class MediaUtils {

	private static Map<String, MediaType> mediaMap;
	
	static {
		mediaMap = new HashMap<>();
		mediaMap.put("JPG", MediaType.IMAGE_JPEG);		// image/jpeg
		mediaMap.put("JPEG", MediaType.IMAGE_JPEG);		// image/jpeg
		mediaMap.put("GIF", MediaType.IMAGE_GIF);		// image/gif
		mediaMap.put("PNG", MediaType.IMAGE_PNG);		// image/png
	}
	
	/**
	 * @param - 업로드 된 파일 확장자 명
	 * @return
	 */
	public static MediaType getMediaType(String ext) {
		return mediaMap.get(ext.toUpperCase());
	}
	
}














