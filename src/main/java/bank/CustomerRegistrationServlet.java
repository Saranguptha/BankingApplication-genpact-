package bank;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import customer.Customer;
import java.util.Random;

@SuppressWarnings("serial")
@WebServlet("/CustomerRegistrationServlet")
public class CustomerRegistrationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullname");
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phoneno");
        String accountType = request.getParameter("account_type");
        String dateOfBirth = request.getParameter("dob");
        String idProof = request.getParameter("idproof");
        String emailId = request.getParameter("emailid");
        
        // Check if any required parameter is missing
        if (fullName == null || address == null || phoneNumber == null || accountType == null || dateOfBirth == null || idProof == null || emailId == null) {
            throw new ServletException("One or more required parameters are missing");
        }

        // Generate a random password and account number
        String password = generateRandomPassword();
        int accountNo = generateAccountNumber();

        Connection connection = null;
        try {
            // Ensure the driver is loaded
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/db1?useSSL=false&allowPublicKeyRetrieval=true", "root", "root");
            
            CustomerRegistrationDAO registrationDAO = new CustomerRegistrationDAO(connection);

            Customer customer = new Customer();
            customer.setFullName(fullName);
            customer.setAddress(address);
            customer.setPhoneNumber(phoneNumber);
            customer.setAccount_type(accountType);
            customer.setDateOfBirth(dateOfBirth);
            customer.setIdProof(idProof);
            customer.setEmailId(emailId);
            customer.setPassword(password);
            customer.setAccountNo(accountNo);

            boolean success = registrationDAO.registerCustomer(customer);

            if (success) {
                request.setAttribute("accountno", accountNo);
                request.setAttribute("password", password);
                request.getRequestDispatcher("/registrationcompleted.jsp").forward(request, response);
            } else {
                response.sendRedirect("registrationfailed.jsp");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            throw new ServletException("Error communicating with database", e);
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("registrationform.jsp");
    }

    private String generateRandomPassword() {
        int length = 8;
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%&";
        Random rnd = new Random();
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return sb.toString();
    }

    private int generateAccountNumber() {
        return (int) (Math.random() * 1000000);
    }
}
