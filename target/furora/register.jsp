
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account | Furora</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f7f4;
            color: #26352c;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
        }

        .register-card {
            width: 100%;
            max-width: 460px;
            background: white;
            padding: 34px;
            border-radius: 16px;
            box-shadow: 0 8px 28px rgba(0, 0, 0, 0.09);
        }

        .brand {
            text-align: center;
            color: #28764b;
            font-size: 30px;
            font-weight: bold;
            margin-bottom: 8px;
        }

        h1 {
            text-align: center;
            font-size: 23px;
            margin: 8px 0;
        }

        .subtitle {
            text-align: center;
            color: #68736b;
            font-size: 14px;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin: 15px 0 7px;
            font-weight: 600;
            font-size: 14px;
        }

        input, select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccd5ce;
            border-radius: 8px;
            font-size: 15px;
        }

        input:focus, select:focus {
            outline: 2px solid #a7d9b8;
            border-color: #28764b;
        }

        button {
            width: 100%;
            margin-top: 24px;
            padding: 13px;
            border: none;
            border-radius: 8px;
            background: #28764b;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #1f5e3b;
        }

        .message {
            padding: 11px;
            margin: 14px 0;
            border-radius: 8px;
            font-size: 14px;
            background: #fff1ef;
            color: #a12a20;
        }

        .success-note {
            background: #eaf7ee;
            color: #21643a;
        }

        .footer {
            text-align: center;
            margin-top: 22px;
            font-size: 14px;
        }

        a {
            color: #28764b;
            font-weight: bold;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
<div class="register-card">

    <div class="brand">Furora</div>
    <h1>Create Your Account</h1>
    <p class="subtitle">Join us in helping pets find loving homes.</p>

    <% String error = request.getParameter("error"); %>

    <% if ("missing".equals(error)) { %>
        <div class="message">Please complete all fields.</div>
    <% } else if ("role".equals(error)) { %>
        <div class="message">Please select a valid account type.</div>
    <% } else if ("password".equals(error)) { %>
        <div class="message">Your passwords do not match.</div>
    <% } else if ("weak".equals(error)) { %>
        <div class="message">Password must contain at least 8 characters.</div>
    <% } else if ("exists".equals(error)) { %>
        <div class="message">An account with this email already exists. Please log in.</div>
    <% } else if ("server".equals(error)) { %>
        <div class="message">Registration failed. Please try again.</div>
    <% } %>

    <form action="register" method="post">

        <label for="name">Full Name</label>
        <input type="text" id="name" name="name"
               maxlength="100" required autocomplete="name">

        <label for="email">Email Address</label>
        <input type="email" id="email" name="email"
               maxlength="100" required autocomplete="email">

        <label for="role">I want to join as</label>
        <select id="role" name="role" required>
            <option value="ADOPTER">Adopter — adopt a pet</option>
            <option value="SHELTER">Shelter — list pets for adoption</option>
        </select>

        <label for="password">Password</label>
        <input type="password" id="password" name="password"
               minlength="8" required autocomplete="new-password">

        <label for="confirmPassword">Confirm Password</label>
        <input type="password" id="confirmPassword"
               name="confirmPassword" minlength="8"
               required autocomplete="new-password">

        <button type="submit">Create Account</button>
    </form>

    <div class="footer">
        Already have an account?
        <a href="login.jsp">Log In</a>
    </div>

</div>
</body>
</html>
