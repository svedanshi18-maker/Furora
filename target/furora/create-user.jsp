<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Create User - Furora</title>

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
            max-width: 650px;
            margin: 45px auto;
        }

        .form-card {
            background: white;
            padding: 40px;
            border-radius: 18px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.10);
        }

        .icon {
            text-align: center;
            font-size: 55px;
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
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #6b4f3a;
            font-weight: bold;
        }

        input,
        select {
            width: 100%;
            padding: 13px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            font-family: Arial, sans-serif;
        }

        input:focus,
        select:focus {
            outline: none;
            border-color: #b06b3c;
        }

        .note {
            background: #fff3e6;
            color: #795548;
            padding: 13px;
            border-radius: 8px;
            margin-bottom: 25px;
            font-size: 14px;
            line-height: 1.5;
        }

        .buttons {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }

        .create-btn,
        .cancel-btn {
            flex: 1;
            padding: 13px;
            border-radius: 25px;
            text-align: center;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .create-btn {
            border: none;
            background: #b06b3c;
            color: white;
        }

        .create-btn:hover {
            background: #8f512d;
        }

        .cancel-btn {
            background: #eee3d9;
            color: #6b4f3a;
        }

        .cancel-btn:hover {
            background: #e1d3c6;
        }

        footer {
            text-align: center;
            padding: 25px;
            margin-top: 60px;
            background: #4b3621;
            color: white;
        }

        @media (max-width: 650px) {

            header {
                padding: 20px;
                flex-direction: column;
                gap: 15px;
            }

            nav a {
                margin-left: 10px;
                margin-right: 10px;
            }

            .form-card {
                padding: 25px;
            }

            .buttons {
                flex-direction: column;
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

        <a href="admin-dashboard.jsp">
            Dashboard
        </a>

    </nav>

</header>


<main class="page-container">


    <div class="form-card">


        <div class="icon">
            👤
        </div>


        <h1>
            Create New User
        </h1>


        <p class="subtitle">
            Add a new administrator, shelter, or adopter account.
        </p>


        <div class="note">

            <strong>Admin notice:</strong>
            Make sure the email address is unique and select the
            correct account role.

        </div>


        <form
                action="create-user"
                method="post">


            <div class="form-group">

                <label for="name">
                    Full Name *
                </label>

                <input
                        type="text"
                        id="name"
                        name="name"
                        placeholder="Enter full name"
                        required
                >

            </div>


            <div class="form-group">

                <label for="email">
                    Email Address *
                </label>

                <input
                        type="email"
                        id="email"
                        name="email"
                        placeholder="Enter email address"
                        required
                >

            </div>


            <div class="form-group">

                <label for="password">
                    Password *
                </label>

                <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Enter password"
                        minlength="4"
                        required
                >

            </div>


            <div class="form-group">

                <label for="role">
                    Account Role *
                </label>

                <select
                        id="role"
                        name="role"
                        required>

                    <option value="">
                        Select account role
                    </option>

                    <option value="ADOPTER">
                        Adopter
                    </option>

                    <option value="SHELTER">
                        Shelter
                    </option>

                    <option value="ADMIN">
                        Administrator
                    </option>

                </select>

            </div>


            <div class="buttons">


                <a
                        href="admin-users"
                        class="cancel-btn">

                    Cancel

                </a>


                <button
                        type="submit"
                        class="create-btn">

                    Create User

                </button>


            </div>


        </form>


    </div>


</main>


<footer>

    <p>
        © 2026 Furora | A New Beginning for Every Pet
    </p>

</footer>


</body>

</html>