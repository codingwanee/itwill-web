package site.itwill.action;

//ȸ�������� �����ϱ� ���� Ŭ���� >> VO Ŭ����, DTO Ŭ����

//�ڹٺ�(JavaBean) : �Է��±����κ��� �Էµ� ���� ���޹޾� �ʵ尪���� �����ϱ� ���� Ŭ����
// => �Է��±��� name �Ӽ����� Ŭ������ �ʵ���� ������ ����
// => �ʵ���� �̿��Ͽ� Getter�� Setter �޼ҵ带 ����
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
