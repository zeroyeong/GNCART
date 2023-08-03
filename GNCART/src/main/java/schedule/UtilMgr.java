package schedule;

import java.io.File;

public class UtilMgr {
	//str :문서 , pattern : 문서에서 찾을 내용, replace : 바꿀내용
	//문서 에서 내용을 찾아 바꾸는 replace 메서드
	public static String replace(String str, String pattern, String replace) {
		int s = 0, e = 0;
		StringBuffer result = new StringBuffer();

		while ((e = str.indexOf(pattern, s)) >= 0) {
			result.append(str.substring(s, e));
			result.append(replace);
			s = e + pattern.length();
		}
		result.append(str.substring(s));
		return result.toString();
	}

	//게시물 삭제시 파일 삭제를 위한 delete 메서드
	public static void delete(String s) {
		File file = new File(s);
		if (file.isFile()) {
			file.delete();
		}
	}
	
	//첨부파일 다운로드 시 파일경로 와 파일명 한글이 깨지지 않도록 
	//8859_1 인코딩 방식 -> ksc5601 인코딩 방식 으로 변환 하는 메서드
	public static String con(String s) {
		String str = null;
		try {
			str = new String(s.getBytes("8859_1"), "ksc5601");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return str;
	}
}
