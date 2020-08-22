package site.itwill.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;
import java.util.regex.Pattern;

//프로그램 작성에 필요한 공통적인 기능들을 제공하는 클래스
public class Utility {
	//원본 문자열과 암호화 알고리즘을 전달받아 원본 문자열을
	//암호화 알고리즘으로 변환하여 반환하는 메소드
	public static String encrypt(String source,String algorithm) {
		String password="";
		try {
			//MessageDigest 클래스 : 암호화 알고리즘을 이용한 암호화 변환 기능을 제공하는 클래스
			//MessageDigest.getInstance(String algorithm)
			// => 암호화 알고리즘을 전달하여 MessageDigest 인스턴스를 반환하는 메소드
			// => NoSuchAlgorithmException 발생 - 예외처리
			//암호화 알고리즘(단방향) : MD5, SHA-1, SHA-256(권장), SHA-512 등
			MessageDigest md=MessageDigest.getInstance(algorithm);
			
			//MessageDigest.update(byte[] source)
			// => MessageDigest 인스턴스에 암호화 하고자 하는 소스를 전달하여 저장하는 메소드
			// => 암호화 하고자 하는 문자열을 byte 배열(원시데이타)로 변환하여 전달
			//String.getBytes() : String 인스턴스를 byte 배열로 변환하여 반환하는 메소드
			md.update(source.getBytes());
			
			//MessageDigest.digest() : MessageDigest 인스턴스에 저장된 
			//정보를 이용하여 암호화 변환한 byte 배열을 반환하는 메소드
			byte[] digest=md.digest();
			
			//byte 배열을 String 인스턴스로 변환하여 저장
			// => byte 배열의 요소값에서 불필요값 제거 후 16진수의 문자열로 변환하여 결합
			for(int i=0;i<digest.length;i++) {
				password+=Integer.toHexString(digest[i]&0xff);
			}
		} catch (NoSuchAlgorithmException e) {
			System.out.println("[에러]잘못된 알고리즘을 전달 하였습니다.");
		}
		return password;		
	}
	
	//새로운 비밀번호를 생성하여 반환하는 메소드
	public static String randomPassword() {
		return UUID.randomUUID().toString()
			.replace("-", "").substring(0, 8).toUpperCase();		
	}
	
	//문자열을 전달받아 문자열에 존재하는 태그 관련 문자열을 
	//모두 제거하고 반환하는 메소드
	public static String stripTag(String source) {
		//Pattern : 정규표현식을 저장하여 사용하기 위한 클래스
		//Pattern.compile(String regEx) : 정규표현식을 저장하고 있는 Pattern 인스턴스를 생성하여 반환하는 메소드
		//Pattern.CASE_INSENSITIVE : 대소문자를 구분하지 않도록 설정하기 위한 상수필드
		Pattern htmlScript=Pattern.compile("\\]*?<.*?\\/script\\>",Pattern.CASE_INSENSITIVE);
		Pattern htmlStyle=Pattern.compile("\\]*?<.*?\\/style\\>",Pattern.CASE_INSENSITIVE);
		Pattern htmlOption=Pattern.compile("\\]*?<.*?\\/option\\>",Pattern.CASE_INSENSITIVE);
		Pattern htmlTag=Pattern.compile("\\<.*?\\>",Pattern.CASE_INSENSITIVE);
		
		//htmlScript.matcher(String source) : 정규표현식과 
		//전달문자열을 비교 처리하기 위한 Matcher 인스턴스를 반환하는 메소드
		//Matcher.replaceAll(String replacement) : 정규표현식과 동일한 문자열을 찾아 원하는 문자열로 변경하는 메소드
		//전달 문자열의 모든 태그 제거
		source=htmlScript.matcher(source).replaceAll("");
		source=htmlStyle.matcher(source).replaceAll("");
		source=htmlOption.matcher(source).replaceAll("");
		source=htmlTag.matcher(source).replaceAll("");
			
		return source;
	}
}






