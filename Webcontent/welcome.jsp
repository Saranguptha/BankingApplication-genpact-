<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="bank.WithdrawaDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(to right, #e0f7fa, #80deea);
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 90%;
            max-width: 900px;
            margin: 40px auto;
            padding: 30px;
            background: #ffffff;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            border-radius: 12px;
            border: 1px solid #e0e0e0;
            display: flex;
            flex-direction: column;
            min-height: 600px;
        }
        h2 {
            color: #00796b;
            font-size: 28px;
            margin-bottom: 20px;
            border-bottom: 3px solid #00796b;
            padding-bottom: 10px;
        }
        h3 {
            color: #004d40;
            font-size: 24px;
            margin-top: 20px;
            border-bottom: 2px solid #004d40;
            padding-bottom: 10px;
        }
        p {
            font-size: 18px;
            margin: 15px 0;
        }
        form {
            margin-top: 20px;
            padding: 20px;
            border: 1px solid #b2dfdb;
            border-radius: 8px;
            background: #f0f4f4;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
        }
        label {
            display: block;
            margin: 10px 0 5px;
            font-weight: 600;
            color: #00796b;
        }
        input[type="text"], input[type="password"] {
            padding: 12px;
            border: 1px solid #b2dfdb;
            border-radius: 5px;
            font-size: 16px;
            width: calc(100% - 24px);
            margin: 10px 0;
            box-sizing: border-box;
        }
        .radio-group {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 15px;
        }
        .radio-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        a.button {
            display: inline-block;
            padding: 14px 20px;
            background: #00796b;
            color: #ffffff;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
            margin-top: 10px;
        }
        a.button:hover {
            background: #004d40;
            transform: scale(1.05);
        }
        .view-transaction {
            margin-top: auto;
            text-align: center;
        }
        .close-account {
            margin-top: 20px;
            padding: 25px;
            border: 2px solid #e74c3c;
            border-radius: 10px;
            background: #fee6e6;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 700px;
            text-align: center;
        }
        .close-account h3 {
            color: #e74c3c;
            font-size: 28px;
            margin-bottom: 20px;
        }
        .close-account form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .close-account label {
            font-size: 18px;
            color: #e74c3c;
            margin-bottom: 15px;
        }
        .close-account input[type="text"] {
            padding: 12px;
            border: 1px solid #e74c3c;
            border-radius: 8px;
            font-size: 16px;
            width: 80%;
            max-width: 400px;
            margin-bottom: 20px;
            box-sizing: border-box;
        }
        .close-account .submit-button {
            padding: 14px 24px;
            background: #e74c3c;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }
        .close-account .submit-button:hover {
            background: #c0392b;
            transform: scale(1.05);
        }
        .error-message {
            color: #f44336;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Welcome, <%= session.getAttribute("Username") %></h2>
        <%
            String username = (String) session.getAttribute("Username");

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                conn = WithdrawaDAO.getConnection();
                String query = "SELECT * FROM customer2 WHERE Username = ?";
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, username);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    out.println("<p><strong>Full Name:</strong> " + rs.getString("Fullname") + "</p>");
                    out.println("<p><strong>Address:</strong> " + rs.getString("Address") + "</p>");
                    out.println("<p><strong>Phone Number:</strong> " + rs.getString("Phonenumber") + "</p>");
                    out.println("<p><strong>Email ID:</strong> " + rs.getString("Emailid") + "</p>");
                    out.println("<p><strong>Account Number:</strong> " + rs.getInt("Accountno") + "</p>");
                    out.println("<p><strong>Balance:</strong> &#8377;" + String.format("%.2f", rs.getDouble("Initialbalance")) + "</p>");
                } else {
                    out.println("<p>No customer details found for username: " + username + "</p>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p class='error-message'>An error occurred while fetching customer details.</p>");
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
        <h3>Banking Operations</h3>
        <form action="withdrawServlet" method="post">
            <label for="amount">Amount:</label>
            <input type="text" id="amount" name="amount" placeholder="Enter the amount" required><br>
            <label>Action:</label>
            <div class="radio-group">
                <div class="radio-item">
                    <input type="radio" id="withdraw" name="action" value="withdraw" checked>
                    <label for="withdraw">Withdraw</label>
                </div>
                <div class="radio-item">
                    <input type="radio" id="deposit" name="action" value="deposit">
                    <label for="deposit">Deposit</label>
                </div>
            </div>
            <input type="submit" value="Process">
        </form>
        <div class="view-transaction">
            <a href="changePassword.jsp" class="button">Change Password</a>
            <a href="transactionHistory.jsp" class="button">View Transaction History</a>
            <a href="logoutServlet" class="button">Logout</a>
        </div>
        <div class="close-account">
            <h3><i class="fas fa-trash-alt"></i> Close Account</h3>
            <% 
                String closeError = request.getParameter("error");
                if (closeError != null) {
                    String errorMessage = "Error: " + closeError;
                    if ("balanceNotZero".equals(closeError)) {
                        errorMessage = "To close the account, your balance must be zero.";
                    }
                    out.println("<p class='error-message'>" + errorMessage + "</p>");
                }
            %>
            <form action="closeAccountServlet" method="post">
                <label for="confirmClose">Type <strong>"CLOSE"</strong> to confirm:</label>
                <input type="text" id="confirmClose" name="confirmClose" placeholder="CLOSE" required>
                <input type="submit" value="Close Account" class="submit-button">
            </form>
        </div>
    </div>
</body>
</html>
