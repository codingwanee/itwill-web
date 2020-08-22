package site.itwill.action;

//회원정보를 저장하기 위한 클래스 >> VO 클래스, DTO 클래스

//자바빈(JavaBean) : 입력태그으로부터 입력된 값을 전달받아 필드값으로 저장하기 위한 클래스
// => 입력태그의 name 속성값과 클래스의 필드명을 같도록 선언
// => 필드명을 이용하여 Getter와 Setter 메소드를 선언
public class Hewon {
	private String name;
	private String phone;
	private String address;
	
	public Hewon() {
		// TODO Auto-generated constructor stub
	}

	public Hewon(String name, String phone, String address) {
		super();
		this.name = name;
		this.phone = phone;
		this.address = address;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
}
