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


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri =request.getRequestURI();
		String contextPath = request.getContextPath();
		String comment =  uri.substring(contextPath.length()+1);
		String[] comments = comment.split("/");

		if(comments[0].equals("user")) {
			UserController user = new UserController(request, response,comments);
		}else if(comments[0].equals("attendance")) {
			AttendanceController attendance = new AttendanceController(request, response,comments);
		}else if(comments[0].equals("mypage")) {
			MyPageController mypage = new MyPageController(request, response,comments);
		}else if(comments[0].equals("class")) {
			ClassController cours = new ClassController(request, response,comments);
		}else if(comments[0].equals("library")) {
			library_controller library = new library_controller(request, response,comments);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
