<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Adoption Statistics - Furora</title>

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
            margin: 45px auto;
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

        .section-title {
            color: #6b4f3a;
            margin: 35px 0 20px;
            font-size: 24px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }

        .stat-card {
            background: white;
            padding: 28px 20px;
            border-radius: 16px;
            text-align: center;
            box-shadow: 0 7px 20px rgba(0, 0, 0, 0.08);
        }

        .stat-icon {
            font-size: 40px;
            margin-bottom: 12px;
        }

        .stat-number {
            font-size: 32px;
            font-weight: bold;
            color: #b06b3c;
            margin-bottom: 8px;
        }

        .stat-label {
            color: #666;
            font-weight: bold;
        }

        .total-card {
            background: #6b4f3a;
        }

        .total-card .stat-number,
        .total-card .stat-label {
            color: white;
        }

        .back-btn {
            display: inline-block;
            margin-top: 40px;
            padding: 11px 22px;
            background: #6b4f3a;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: bold;
        }

        .back-btn:hover {
            background: #543b2b;
        }

        footer {
            text-align: center;
            padding: 25px;
            margin-top: 70px;
            background: #4b3621;
            color: white;
        }

        @media (max-width: 850px) {

            header {
                padding: 20px;
                flex-direction: column;
                gap: 10px;
            }

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }

        }

        @media (max-width: 500px) {

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .heading h1 {
                font-size: 30px;
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
            Adoption Statistics 📊
        </h1>

        <p>
            View the adoption activity and pet listing statistics for your shelter.
        </p>

    </div>


    <!-- Pet Statistics -->

    <h2 class="section-title">
        🐾 Pet Listing Statistics
    </h2>


    <div class="stats-grid">


        <div class="stat-card total-card">

            <div class="stat-icon">
                🐾
            </div>

            <div class="stat-number">
                ${totalPets}
            </div>

            <div class="stat-label">
                Total Pets
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                ✅
            </div>

            <div class="stat-number">
                ${approvedPets}
            </div>

            <div class="stat-label">
                Approved Pets
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                ⏳
            </div>

            <div class="stat-number">
                ${pendingPets}
            </div>

            <div class="stat-label">
                Pending Pets
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                ❌
            </div>

            <div class="stat-number">
                ${rejectedPets}
            </div>

            <div class="stat-label">
                Rejected Pets
            </div>

        </div>


    </div>


    <!-- Application Statistics -->

    <h2 class="section-title">
        📋 Adoption Application Statistics
    </h2>


    <div class="stats-grid">


        <div class="stat-card total-card">

            <div class="stat-icon">
                📋
            </div>

            <div class="stat-number">
                ${totalApplications}
            </div>

            <div class="stat-label">
                Total Applications
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                ⏳
            </div>

            <div class="stat-number">
                ${pendingApplications}
            </div>

            <div class="stat-label">
                Pending Applications
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                ✅
            </div>

            <div class="stat-number">
                ${approvedApplications}
            </div>

            <div class="stat-label">
                Approved Applications
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                ❌
            </div>

            <div class="stat-number">
                ${rejectedApplications}
            </div>

            <div class="stat-label">
                Rejected Applications
            </div>

        </div>


    </div>


    <a
            href="shelter-dashboard.jsp"
            class="back-btn">

        ← Back to Dashboard

    </a>


</main>


<footer>

    <p>
        © 2026 Furora | A New Beginning for Every Pet
    </p>

</footer>


</body>

</html>