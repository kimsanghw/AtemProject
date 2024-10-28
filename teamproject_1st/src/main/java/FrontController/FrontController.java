package FrontController;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public FrontController() {
        super();
       
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("fontcontroller ����, url:"
				+request.getRequestURI());
		String uri =request.getRequestURI();
		String contextPath = request.getContextPath();
		
		String comment =  uri.substring(contextPath.length()+1);
		System.out.println("comment:"+comment);
		String[] comments = comment.split("/");

		System.out.println("comments[0] : "+comments[0]);
		
		

		
		System.out.println("team project!!");

		if(comments[0].equals("user")) {
			System.out.println("login.do!!!");
			UserController user = new UserController(request, response,comments);
		}else if(comments[0].equals("attendance")) {
			AttendanceController attendance = new AttendanceController(request, response,comments);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
