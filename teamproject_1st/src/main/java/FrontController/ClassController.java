package FrontController;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ClassController {
	public ClassController(HttpServletRequest request, HttpServletResponse response, String[] comments) throws ServletException, IOException  {
	
		if(comments[comments.length-1].equals("list.do")) {
			list(request,response);
		}else if(comments[comments.length-1].equals("modify.do")) {
			
			if(request.getMethod().equals("GET")) {
				//���������� ��û ���� ��
				modify(request,response);
				
			}else if(request.getMethod().equals("POST")) {
				//�������������� ������ ���� �� ����� ���� ��
				modifyOk(request,response);
			}
		}else if(comments[comments.length-1].equals("delete.do")) {
			delete(request,response);
		}
		public void list (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
		}
	}
}
