<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Registration</title>
</head>
<body>
    <h1>Customer Registration</h1>
    <form action="CustomerRegistrationServlet" method="post">
        <label for="fullname">Full Name:</label>
        <input type="text" id="fullname" name="fullname" required><br><br>

        <label for="address">Address:</label>
        <input type="text" id="address" name="address" required><br><br>

        <label for="phoneno">Phone Number:</label>
        <input type="text" id="phoneno" name="phoneno" required><br><br>

        <label for="account_type">Account Type:</label>
        <input type="text" id="account_type" name="account_type" required><br><br>

        <label for="dob">Date of Birth:</label>
        <input type="date" id="dob" name="dob" required><br><br>

        <label for="idproof">ID Proof:</label>
        <input type="text" id="idproof" name="idproof" required><br><br>

        <label for="emailid">Email ID:</label>
        <input type="email" id="emailid" name="emailid" required><br><br>

        <button type="submit">Register</button>
    </form>
</body>
</html>
