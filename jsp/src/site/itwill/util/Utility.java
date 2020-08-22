package site.itwill.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;
import java.util.regex.Pattern;

//���α׷� �ۼ��� �ʿ��� �������� ��ɵ��� �����ϴ� Ŭ����
public class Utility {
	//���� ���ڿ��� ��ȣȭ �˰����� ���޹޾� ���� ���ڿ���
	//��ȣȭ �˰������� ��ȯ�Ͽ� ��ȯ�ϴ� �޼ҵ�
	public static String encrypt(String source,String algorithm) {
		String password="";
		try {
			//MessageDigest Ŭ���� : ��ȣȭ �˰����� �̿��� ��ȣȭ ��ȯ ����� �����ϴ� Ŭ����
			//MessageDigest.getInstance(String algorithm)
			// => ��ȣȭ �˰����� �����Ͽ� MessageDigest �ν��Ͻ��� ��ȯ�ϴ� �޼ҵ�
			// => NoSuchAlgorithmException �߻� - ����ó��
			//��ȣȭ �˰���(�ܹ���) : MD5, SHA-1, SHA-256(����), SHA-512 ��
			MessageDigest md=MessageDigest.getInstance(algorithm);
			
			//MessageDigest.update(byte[] source)
			// => MessageDigest �ν��Ͻ��� ��ȣȭ �ϰ��� �ϴ� �ҽ��� �����Ͽ� �����ϴ� �޼ҵ�
			// => ��ȣȭ �ϰ��� �ϴ� ���ڿ��� byte �迭(���õ���Ÿ)�� ��ȯ�Ͽ� ����
			//String.getBytes() : String �ν��Ͻ��� byte �迭�� ��ȯ�Ͽ� ��ȯ�ϴ� �޼ҵ�
			md.update(source.getBytes());
			
			//MessageDigest.digest() : MessageDigest �ν��Ͻ��� ����� 
			//������ �̿��Ͽ� ��ȣȭ ��ȯ�� byte �迭�� ��ȯ�ϴ� �޼ҵ�
			byte[] digest=md.digest();
			
			//byte �迭�� String �ν��Ͻ��� ��ȯ�Ͽ� ����
			// => byte �迭�� ��Ұ����� ���ʿ䰪 ���� �� 16������ ���ڿ��� ��ȯ�Ͽ� ����
			for(int i=0;i<digest.length;i++) {
				password+=Integer.toHexString(digest[i]&0xff);
			}
		} catch (NoSuchAlgorithmException e) {
			System.out.println("[����]�߸��� �˰����� ���� �Ͽ����ϴ�.");
		}
		return password;		
	}
	
	//���ο� ��й�ȣ�� �����Ͽ� ��ȯ�ϴ� �޼ҵ�
	public static String randomPassword() {
		return UUID.randomUUID().toString()
			.replace("-", "").substring(0, 8).toUpperCase();		
	}
	
	//���ڿ��� ���޹޾� ���ڿ��� �����ϴ� �±� ���� ���ڿ��� 
	//��� �����ϰ� ��ȯ�ϴ� �޼ҵ�
	public static String stripTag(String source) {
		//Pattern : ����ǥ������ �����Ͽ� ����ϱ� ���� Ŭ����
		//Pattern.compile(String regEx) : ����ǥ������ �����ϰ� �ִ� Pattern �ν��Ͻ��� �����Ͽ� ��ȯ�ϴ� �޼ҵ�
		//Pattern.CASE_INSENSITIVE : ��ҹ��ڸ� �������� �ʵ��� �����ϱ� ���� ����ʵ�
		Pattern htmlScript=Pattern.compile("\\]*?<.*?\\/script\\>",Pattern.CASE_INSENSITIVE);
		Pattern htmlStyle=Pattern.compile("\\]*?<.*?\\/style\\>",Pattern.CASE_INSENSITIVE);
		Pattern htmlOption=Pattern.compile("\\]*?<.*?\\/option\\>",Pattern.CASE_INSENSITIVE);
		Pattern htmlTag=Pattern.compile("\\<.*?\\>",Pattern.CASE_INSENSITIVE);
		
		//htmlScript.matcher(String source) : ����ǥ���İ� 
		//���޹��ڿ��� �� ó���ϱ� ���� Matcher �ν��Ͻ��� ��ȯ�ϴ� �޼ҵ�
		//Matcher.replaceAll(String replacement) : ����ǥ���İ� ������ ���ڿ��� ã�� ���ϴ� ���ڿ��� �����ϴ� �޼ҵ�
		//���� ���ڿ��� ��� �±� ����
		source=htmlScript.matcher(source).replaceAll("");
		source=htmlStyle.matcher(source).replaceAll("");
		source=htmlOption.matcher(source).replaceAll("");
		source=htmlTag.matcher(source).replaceAll("");
			
		return source;
	}
}






