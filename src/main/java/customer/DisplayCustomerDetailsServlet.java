package customer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DisplayCustomerDetailsServlet")
public class DisplayCustomerDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Customer> customers = retrieveCustomerDataFromDatabase();

        // Set customers as a request attribute
        request.setAttribute("customers", customers);

        // Forward to JSP to display data
        request.getRequestDispatcher("/customerdetails.jsp").forward(request, response);
    }

    private List<Customer> retrieveCustomerDataFromDatabase() throws ServletException {
        List<Customer> customers = new ArrayList<>();

        String url = "jdbc:mysql://localhost:3306/db1";
        String username = "root";
        String password = "root";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT fullname, phoneno, emailid, accountno, address, dob, account_type, idproof FROM customers")) {

            // Iterate through result set and create Customer objects
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setFullName(rs.getString("fullname"));
                customer.setPhoneNumber(rs.getString("phoneno"));
                customer.setEmailId(rs.getString("emailid"));
                customer.setAccountNumber(rs.getString("accountno"));
                customer.setAddress(rs.getString("address"));
                customer.setDob(rs.getDate("dob"));
                customer.setTypeOfAccount(rs.getString("account_type"));
                customer.setIdProof(rs.getString("idproof"));

                customers.add(customer);
            }
        } catch (SQLException e) {
            // Handle SQL exception with a more specific message
            throw new ServletException("Database access error occurred.", e);
        }

        return customers;
    }
}
