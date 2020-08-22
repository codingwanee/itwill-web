package site.itwill.custom;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

//JSP �������� ���� �±׸� Ŭ������ ���� - �±� Ŭ����
// => TagSupport Ŭ������ ��ӹ޾� �ۼ�
public class CustomTag extends TagSupport {
	private static final long serialVersionUID = 1L;

	@Override
	public int doStartTag() throws JspException {
		try {
			pageContext.getOut().println("<h3>Ŀ���� �±� ���</h3>");
		} catch (IOException e) {
			e.printStackTrace();	
		}
		return super.doStartTag();
	}
}
