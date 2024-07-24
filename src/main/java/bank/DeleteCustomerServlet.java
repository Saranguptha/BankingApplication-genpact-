package bank;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteCustomerServlet")
public class DeleteCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/db1?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNo = request.getParameter("accountno");

        if (accountNo == null || accountNo.isEmpty()) {
            response.sendRedirect("customerdetails.jsp?error=Invalid Account Number");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // Check balance
            String checkBalanceSql = "SELECT initialbalance FROM customers WHERE accountno = ?";
            stmt = conn.prepareStatement(checkBalanceSql);
            stmt.setString(1, accountNo);
            rs = stmt.executeQuery();

            if (rs.next()) {
                double balance = rs.getDouble("initialbalance");

                if (balance > 0) {
                    response.sendRedirect("displaycustomerdetails.jsp?error=Cannot delete customer with non-zero balance");
                    return;
                }

                // Proceed with deletion
                String deleteSql = "DELETE FROM customers WHERE accountno = ?";
                stmt = conn.prepareStatement(deleteSql);
                stmt.setString(1, accountNo);
                stmt.executeUpdate();

                response.sendRedirect("customerdetails.jsp?message=Customer deleted successfully");
            } else {
                response.sendRedirect("customerdetails.jsp?error=Customer not found");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("customerdetails.jsp?error=Database error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
