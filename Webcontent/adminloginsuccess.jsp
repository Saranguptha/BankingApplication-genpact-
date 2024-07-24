<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <script>
        function showSuccessMessage() {
            var successMessage = document.getElementById('success-message');
            successMessage.style.display = 'block';
            setTimeout(function() {
                successMessage.style.display = 'none';
            }, 3000);
        }
        window.onload = showSuccessMessage;
    </script>
</head>
<body>
    <div class="container">
        <h1>Welcome Admin</h1>
        <h2>Welcome to your Dashboard</h2>
        <div id="success-message" class="success-message">Login Successfully</div></br>
      <br><a href="CustomerRegistration.jsp" class="button">Customer Registration</a></br>
      <br><a href="customerdetails.jsp" class="button">Customer Details</a></br>
      <br><a href="logoutServlet" class="button">Logout</a></br>
    </div>
    <div class="footer">
        &copy; WELCOME TO GENPACT BANK WEBSITE
    </div>
</body>
</html>
