package site.itwill.util;

public class Utility {
	//JSON 형식의 텍스트 데이타에서 표현 불가능한 문자를 제어문자(Escape Character)로 변환하여 반환하는 메소드
	public static String toJSON(String source) {
		return source.replace("\\", "\\\\").replace("\"", "\\\"")
			.replace("\'", "\\\'").replace("\n", "\\n").replace("\r\n", "\\n");
	}
}
