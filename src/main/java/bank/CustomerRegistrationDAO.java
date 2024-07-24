package bank;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import customer.Customer;

public class CustomerRegistrationDAO {
    private Connection connection;

    public CustomerRegistrationDAO(Connection connection) {
        this.connection = connection;
    }

    public boolean registerCustomer(Customer customer) throws SQLException {
        String sql = "INSERT INTO customers (fullname, address, phoneno, account_type, dob, idproof, emailid, password, accountno) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, customer.getFullName());
            statement.setString(2, customer.getAddress());
            statement.setString(3, customer.getPhoneNumber());
            statement.setString(4, customer.getAccount_type());
            statement.setString(5, customer.getDateOfBirth());
            statement.setString(6, customer.getIdProof());
            statement.setString(7, customer.getEmailId());
            statement.setString(8, customer.getPassword());
            statement.setInt(9, customer.getAccountNo());

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        }
    }
}
