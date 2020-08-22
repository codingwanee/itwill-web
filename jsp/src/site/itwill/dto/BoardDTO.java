package site.itwill.dto;

/*
�̸�        ��?       ����             
--------- -------- -------------- 
NUM       NOT NULL NUMBER(4)      - �Խñ� ��ȣ(������) : �ڵ�������   
ID                 VARCHAR2(20)   - �ۼ��� ���̵� : �α��� ������� ���̵�
WRITER             VARCHAR2(50)   - �ۼ��� �̸� : �α��� ������� �̸�
SUBJECT            VARCHAR2(500)  - �Խñ� ���� : �Է°�
REG_DATE           DATE           - �Խñ� �ۼ����� : ����(���峯¥)  
READCOUNT          NUMBER(4)      - �Խñ� ��Ƚ�� : 0
REF                NUMBER(4)      - �Խñ� �׷��ȣ : ���
RE_STEP            NUMBER(4)      - �Խñ� �׷���� : ���
RE_LEVEL           NUMBER(4)      - �Խñ� ���� : ��� 
CONTENT            VARCHAR2(4000) - �Խñ� ���� : �Է°�
IP                 VARCHAR2(20)   - �Խñ� �ۼ� ��ǻ���� IP �ּ� : Ŭ���̾�Ʈ IP �ּ�
STATUS             NUMBER(1)      - �Խñ� ���� : 0(�Ϲݱ�), 1(��б�), 9(������)
*/
public class BoardDTO {
	private int num;
	private String id;
	private String writer;
	private String subject;
	private String regDate;
	private int readCount;
	private int ref;
	private int reStep;
	private int reLevel;
	private String content;
	private String ip;
	private int status;
	
	public BoardDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getReStep() {
		return reStep;
	}

	public void setReStep(int reStep) {
		this.reStep = reStep;
	}

	public int getReLevel() {
		return reLevel;
	}

	public void setReLevel(int reLevel) {
		this.reLevel = reLevel;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
}
