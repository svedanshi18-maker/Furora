<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Login - Furora</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f7f4ef;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .login-container {
            width: 380px;
            background: white;
            padding: 35px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
        }

        .logo {
            text-align: center;
            font-size: 32px;
            font-weight: bold;
            color: #6b4f3a;
            margin-bottom: 8px;
        }

        .subtitle {
            text-align: center;
            color: #777;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
            color: #444;
        }

        input {
            width: 100%;
            box-sizing: border-box;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
        }

        input:focus {
            outline: none;
            border-color: #6b4f3a;
        }

        button {
            width: 100%;
            padding: 13px;
            border: none;
            border-radius: 8px;
            background: #6b4f3a;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #543b2b;
        }

        .register-text {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }

        .register-text a {
            color: #6b4f3a;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>

<body>

<div class="login-container">

    <div class="logo">🐾 Furora</div>

    <div class="subtitle">
        Welcome back! Login to continue.
    </div>

    <form action="login" method="post">

        <label for="email">Email</label>

        <input
                type="email"
                id="email"
                name="email"
                placeholder="Enter your email"
                required
        >

        <label for="password">Password</label>

        <input
                type="password"
                id="password"
                name="password"
                placeholder="Enter your password"
                required
        >

        <button type="submit">
            Login
        </button>

    </form>

    <div class="register-text">
        Don't have an account?
        <a href="register.jsp">Create Account</a>
    </div>

</div>

</body>

</html>