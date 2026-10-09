
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String role = request.getParameter("role");

    if (role == null ||
        !(role.equals("ADOPTER") ||
          role.equals("SHELTER") ||
          role.equals("ADMIN"))) {
        response.sendRedirect("index.jsp");
        return;
    }

    String roleTitle = "ADOPTER".equals(role) ? "Adopter"
            : "SHELTER".equals(role) ? "Shelter"
            : "Administrator";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= roleTitle %> Login - Furora</title>

    <style>
        * { box-sizing: border-box; }

        body {
            margin: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background: #f7f1e9;
            color: #4b3024;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .login-container {
            width: 100%;
            max-width: 400px;
            background: #fffaf4;
            padding: 36px;
            border: 1px solid #e6d5c4;
            border-radius: 18px;
            box-shadow: 0 12px 35px rgba(75, 48, 36, 0.10);
        }

        .logo {
            text-align: center;
            font-size: 32px;
            font-weight: bold;
            color: #70452f;
            margin-bottom: 8px;
        }

        .subtitle {
            text-align: center;
            color: #806b5b;
            margin-bottom: 26px;
            line-height: 1.6;
        }

        .role {
            background: #eee0d0;
            color: #70452f;
            padding: 10px;
            border-radius: 8px;
            text-align: center;
            font-weight: bold;
            margin-bottom: 24px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-weight: 600;
            color: #4b3024;
        }

        input {
            width: 100%;
            padding: 12px;
            margin-bottom: 19px;
            border: 1px solid #d9c6b4;
            border-radius: 8px;
            font-size: 15px;
            background: white;
        }

        input:focus {
            outline: 2px solid #b17b53;
            border-color: #70452f;
        }

        button {
            width: 100%;
            padding: 13px;
            border: none;
            border-radius: 8px;
            background: #70452f;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover { background: #523321; }

        .register-text, .back {
            text-align: center;
            margin-top: 20px;
            color: #806b5b;
            font-size: 14px;
        }

        a {
            color: #70452f;
            font-weight: bold;
            text-decoration: none;
        }

        a:hover { text-decoration: underline; }
    </style>
</head>

<body>
<div class="login-container">
    <div class="logo">🐾 Furora</div>

    <div class="subtitle">
        Welcome back! Login to continue.
    </div>

    <div class="role"><%= roleTitle %> Login</div>

    <form action="login" method="post">
        <input type="hidden" name="role" value="<%= role %>">

        <label for="email">Email</label>
        <input type="email" id="email" name="email"
               placeholder="Enter your email" required>

        <label for="password">Password</label>
        <input type="password" id="password" name="password"
               placeholder="Enter your password" required>

        <button type="submit">Login</button>
    </form>

    <% if (!"ADMIN".equals(role)) { %>
        <div class="register-text">
            Don't have an account?
            <a href="register.jsp?role=<%= role %>">Create Account</a>
        </div>
    <% } else { %>
        <div class="register-text">
            Administrator accounts are created privately.
        </div>
    <% } %>

    <div class="back">
        <a href="index.jsp">← Back to role selection</a>
    </div>
</div>
</body>
</html>
