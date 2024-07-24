<!DOCTYPE html>
<html lang="en">
<body>
    <div class="login-container">
        <h2>Customer Login</h2>
        <form action="loginServlet" method="POST">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
            
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>
