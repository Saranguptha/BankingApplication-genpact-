<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Details</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f0f8ff;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        h2 {
            color: #2f4f4f;
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 15px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #2196F3;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        td {
            transition: background-color 0.3s ease;
        }
        tr:hover td {
            background-color: #eef;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #2196F3;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }
        .button:hover {
            background-color: #1976D2;
        }
        .delete-button {
            padding: 5px 10px;
            background-color: #f44336;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9em;
            transition: background-color 0.3s ease;
        }
        .delete-button:hover {
            background-color: #d32f2f;
        }
    </style>
</head>
<body>
    <h2>Customer Details</h2>
    
    <%-- Display messages --%>
    <%
        String errorMessage = request.getParameter("error");
        String successMessage = request.getParameter("message");

        if (errorMessage != null) {
            out.println("<p style='color: red;'>Error: " + errorMessage + "</p>");
        }

        if (successMessage != null) {
            out.println("<p style='color: green;'>Success: " + successMessage + "</p>");
        }
    %>

    <table>
        <thead>
            <tr>
                <th>Full Name</th>
                <th>Phone Number</th>
                <th>Email ID</th>
                <th>Account No</th>
                <th>Address</th>
                <th>Date of Birth</th>
                <th>Account Type</th>
                <th>ID Proof</th>
              
             
            </tr>
        </thead>
        <tbody>
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // Load MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection to the database
        String url = "jdbc:mysql://localhost:3306/db1"; // Update with your database URL
        String user = "root"; // Update with your database username
        String password = "root"; // Update with your database password
        conn = DriverManager.getConnection(url, user, password);

        // Create SQL statement
        stmt = conn.createStatement();
        String sql = "SELECT fullname, phoneno, emailid, accountno, address, dob, account_type, idproof FROM customers";
        rs = stmt.executeQuery(sql);

        // Iterate through the result set and display the data
        while (rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getString("fullname") + "</td>");
            out.println("<td>" + rs.getString("phoneno") + "</td>");
            out.println("<td>" + rs.getString("emailid") + "</td>");
            out.println("<td>" + rs.getString("accountno") + "</td>");
            out.println("<td>" + rs.getString("address") + "</td>");
            out.println("<td>" + rs.getString("dob") + "</td>");
            out.println("<td>" + rs.getString("account_type") + "</td>");
            out.println("<td>" + rs.getString("idproof") + "</td>");
            out.println("<td><a href='editCustomer.jsp?Accountno=" + rs.getString("accountno") + "' class='edit-button'>Edit</a></td>");
            out.println("<td>");
            out.println("<form action='DeleteCustomerServlet' method='POST' style='display:inline;'>");
            out.println("<input type='hidden' name='accountno' value='" + rs.getString("accountno") + "'>");
            out.println("<button type='submit' class='delete-button'>Delete</button>");
            out.println("</form>");
            out.println("</td>");
            out.println("</tr>");
        }
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<tr><td colspan='11'>Error loading database driver: " + e.getMessage() + "</td></tr>");
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<tr><td colspan='11'>SQL error: " + e.getMessage() + "</td></tr>");
    } finally {
        // Close ResultSet, Statement, and Connection
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>

        </tbody>
    </table>
    <div class="button-container">
        <a href="adminloginsuccess.jsp" class="button">Back to Admin Dashboard</a>
    </div>
</body>
</html>
