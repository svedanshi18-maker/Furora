<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Profile - Furora</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #fffaf5;
            color: #333;
        }

        header {
            background: white;
            padding: 20px 60px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }

        .logo {
            font-size: 28px;
            font-weight: bold;
            color: #6b4f3a;
        }

        nav a {
            text-decoration: none;
            color: #444;
            margin-left: 25px;
            font-size: 15px;
        }

        nav a:hover {
            color: #b06b3c;
        }

        .page-container {
            width: 90%;
            max-width: 700px;
            margin: 50px auto;
        }

        .profile-card {
            background: white;
            padding: 40px;
            border-radius: 18px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.10);
        }

        .profile-icon {
            text-align: center;
            font-size: 65px;
            margin-bottom: 10px;
        }

        h1 {
            text-align: center;
            color: #4b3621;
            margin-bottom: 10px;
        }

        .subtitle {
            text-align: center;
            color: #777;
            margin-bottom: 35px;
        }

        .form-group {
            margin-bottom: 22px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #6b4f3a;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 13px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
        }

        input:focus {
            outline: none;
            border-color: #b06b3c;
        }

        .role-display {
            background: #f7f0e9;
            padding: 13px;
            border-radius: 8px;
            color: #6b4f3a;
            font-weight: bold;
        }

        .save-btn {
            width: 100%;
            padding: 13px;
            border: none;
            border-radius: 25px;
            background: #b06b3c;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .save-btn:hover {
            background: #8f512d;
        }

        .back-btn {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #6b4f3a;
            text-decoration: none;
            font-weight: bold;
        }

        .back-btn:hover {
            color: #b06b3c;
        }

        footer {
            text-align: center;
            padding: 25px;
            margin-top: 60px;
            background: #4b3621;
            color: white;
        }

        @media (max-width: 700px) {

            header {
                padding: 20px;
                flex-direction: column;
                gap: 15px;
            }

            nav a {
                margin-left: 10px;
                margin-right: 10px;
            }

            .profile-card {
                padding: 25px;
            }

        }

    </style>

</head>

<body>


<header>

    <div class="logo">
        Furora 🐾
    </div>

    <nav>

        <a href="index.html">
            Home
        </a>

        <a href="all-pets">
            Find a Pet
        </a>

        <a href="adopter-dashboard.jsp">
            Dashboard
        </a>

    </nav>

</header>


<main class="page-container">

    <div class="profile-card">

        <div class="profile-icon">
            👤
        </div>

        <h1>
            My Profile
        </h1>

        <p class="subtitle">
            Manage your personal information
        </p>


        <form action="profile" method="post">


            <div class="form-group">

                <label for="name">
                    Full Name
                </label>

                <input
                        type="text"
                        id="name"
                        name="name"
                        value="${name}"
                        required
                >

            </div>


            <div class="form-group">

                <label for="email">
                    Email Address
                </label>

                <input
                        type="email"
                        id="email"
                        name="email"
                        value="${email}"
                        required
                >

            </div>


            <div class="form-group">

                <label>
                    Account Role
                </label>

                <div class="role-display">
                    ${role}
                </div>

            </div>


            <button
                    type="submit"
                    class="save-btn">
                Save Changes
            </button>

        </form>


        <a
                href="adopter-dashboard.jsp"
                class="back-btn">
            ← Back to Dashboard
        </a>

    </div>

</main>


<footer>

    <p>
        © 2026 Furora | A New Beginning for Every Pet
    </p>

</footer>


</body>

</html>