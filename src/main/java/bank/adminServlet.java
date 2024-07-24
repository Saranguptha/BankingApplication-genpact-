package bank;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/adminServlet")
public class adminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private adminDAO adminDAO;

    public void init() {
        setAdminDAO(new adminDAO());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleRequest(request, response);
    }

    private void handleRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean valid = adminDAO.validate(username, password);

        if (valid) {
            response.sendRedirect("adminloginsuccess.jsp");
        } else {
            response.sendRedirect("adminloginfail.jsp");
        }
    }

	public adminDAO getAdminDAO() {
		return adminDAO;
	}

	public void setAdminDAO(adminDAO adminDAO) {
		this.adminDAO = adminDAO;
	}
}
