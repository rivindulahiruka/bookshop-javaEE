<%@ page contentType="text/html;charset=UTF-8" %>
<%-- Success Message --%>
<% if (request.getAttribute("successMsg") != null) { %>
    <p style="color: green; text-align: center; margin-bottom: 10px;">
        <%= request.getAttribute("successMsg") %>
    </p>
    <script>
        setTimeout(function () {
            window.location.href = "dashboard.jsp";
        }, 2000);  // 2000 milliseconds = 2 seconds
    </script>
<% } %>
<html>
<head>
    <title>Register</title>
    <style>
        :root {
            --primary-color: #4a6bff;
            --secondary-color: #f8f9fa;
            --text-color: #333;
            --error-color: #e74c3c;
            --success-color: #2ecc71;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f7ff;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 70vh;
            padding: 20px;

        }

        .container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            width: 100%;

            max-width: 500px;
            padding: 30px;
        }

        h2 {
            color: var(--primary-color);
            text-align: center;
            margin-bottom: 25px;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-color);
            font-weight: 500;
        }

        input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border 0.3s;
        }

        input:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 2px rgba(74, 107, 255, 0.2);
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #3a5bef;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            color: var(--text-color);
        }

        .login-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: var(--error-color);
            text-align: center;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .role-selector {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }

        .role-option {
            flex: 1;
        }

        .role-option input[type="radio"] {
            display: none;
        }

        .role-option label {
            display: block;
            padding: 12px;
            background-color: var(--secondary-color);
            border-radius: 5px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
        }

        .role-option input[type="radio"]:checked + label {
            background-color: var(--primary-color);
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Create Your Account</h2>

        <form method="post" action="register">
            <input type="hidden" name="id" value="${id}">

            <div class="form-group">
                <label for="userName">Username</label>
                <input type="text" id="userName" name="username" required placeholder="Enter your username">
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required placeholder="Create a password">
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" required placeholder="Enter your email">
            </div>

            <div class="form-group">
                <label for="phoneNum">Phone Number</label>
                <input type="tel" id="phoneNum" name="phoneNum" placeholder="Enter your phone number">
            </div>

            <div class="form-group">
                <label>Role</label>
                <div class="role-selector">
                    <div class="role-option">
                       <input type="radio" id="admin" name="role" value="ADMIN">
                       <label for="admin">Admin</label>
                    </div>
                    <div class="role-option">
                        <input type="radio" id="customer" name="role" value="CUSTOMER" checked>
                        <label for="customer">Customer</label>
                    </div>
                </div>
            </div>

            <button type="submit">Register</button>
        </form>

        <div class="login-link">
            Already have an account? <a href="loginpage.jsp">Sign in</a>
        </div>
    </div>
</body>
</html>