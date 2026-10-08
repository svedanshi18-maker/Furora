<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Admin Dashboard - Furora</title>

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

        .welcome {
            color: #555;
            font-size: 16px;
        }

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 50px auto;
        }

        .heading {
            text-align: center;
            margin-bottom: 40px;
        }

        .heading h1 {
            color: #4b3621;
            font-size: 36px;
            margin-bottom: 10px;
        }

        .heading p {
            color: #777;
            font-size: 16px;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }

        .card {
            background: white;
            padding: 35px 25px;
            border-radius: 16px;
            text-align: center;
            box-shadow: 0 7px 20px rgba(0, 0, 0, 0.08);
            transition: transform 0.2s;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card-icon {
            font-size: 50px;
            margin-bottom: 15px;
        }

        .card h2 {
            color: #6b4f3a;
            margin-bottom: 10px;
        }

        .card p {
            color: #777;
            line-height: 1.5;
            margin-bottom: 20px;
        }

        .btn {
            display: inline-block;
            padding: 11px 22px;
            background: #b06b3c;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: bold;
        }

        .btn:hover {
            background: #8f512d;
        }

        footer {
            text-align: center;
            padding: 25px;
            margin-top: 70px;
            background: #4b3621;
            color: white;
        }

        @media (max-width: 1000px) {

            .dashboard-grid {
                grid-template-columns: repeat(2, 1fr);
            }

        }

        @media (max-width: 700px) {

            header {
                padding: 20px;
                flex-direction: column;
                gap: 10px;
            }

            .dashboard-grid {
                grid-template-columns: 1fr;
            }

        }

    </style>

</head>

<body>


<header>

    <div class="logo">
        Furora 🐾
    </div>

    <div class="welcome">
        Welcome, ${sessionScope.userName}!
    </div>

</header>


<main class="container">


    <div class="heading">

        <h1>
            Admin Dashboard
        </h1>

        <p>
            Manage users, pet listings, platform settings, and analytics.
        </p>

    </div>


    <div class="dashboard-grid">


        <!-- User Management -->

        <div class="card">

            <div class="card-icon">
                👥
            </div>

            <h2>
                User Management
            </h2>

            <p>
                Manage adopter, shelter, and administrator accounts.
            </p>

            <a
                    href="admin-users"
                    class="btn">

                Manage Users

            </a>

        </div>


        <!-- Pet Listings -->

        <div class="card">

            <div class="card-icon">
                🐾
            </div>

            <h2>
                Pet Listings
            </h2>

            <p>
                Review and approve or reject pet listings submitted by shelters.
            </p>

            <a
                    href="admin-pets"
                    class="btn">

                Manage Pet Listings

            </a>

        </div>


        <!-- System Settings -->

        <div class="card">

            <div class="card-icon">
                ⚙️
            </div>

            <h2>
                System Settings
            </h2>

            <p>
                Configure settings and manage Furora platform preferences.
            </p>

            <a
                    href="system-settings"
                    class="btn">

                System Settings

            </a>

        </div>


        <!-- Platform Analytics -->

        <div class="card">

            <div class="card-icon">
                📊
            </div>

            <h2>
                Platform Analytics
            </h2>

            <p>
                View statistics about users, pets, and adoption applications.
            </p>

            <a
                    href="admin-analytics"
                    class="btn">

                View Analytics

            </a>

        </div>


    </div>

</main>


<footer>

    <p>
        © 2026 Furora | A New Beginning for Every Pet
    </p>

</footer>


</body>

</html>