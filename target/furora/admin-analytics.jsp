<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Platform Analytics - Furora</title>

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
            width: 92%;
            max-width: 1150px;
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
            margin-bottom: 20px;
            font-size: 24px;
        }

        .analytics-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 45px;
        }

        .stat-card {
            background: white;
            padding: 25px 20px;
            border-radius: 15px;
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
            font-size: 15px;
        }

        .summary-card {
            background: white;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 7px 20px rgba(0, 0, 0, 0.08);
            margin-bottom: 35px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }

        .summary-row:last-child {
            border-bottom: none;
        }

        .summary-name {
            color: #555;
            font-weight: bold;
        }

        .summary-value {
            color: #6b4f3a;
            font-size: 20px;
            font-weight: bold;
        }

        .back-btn {
            display: inline-block;
            margin-top: 10px;
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

        @media (max-width: 900px) {

            header {
                padding: 20px;
                flex-direction: column;
                gap: 10px;
            }

            .analytics-grid {
                grid-template-columns: repeat(2, 1fr);
            }

        }

        @media (max-width: 550px) {

            .analytics-grid {
                grid-template-columns: 1fr;
            }

            .container {
                width: 90%;
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
            Platform Analytics 📊
        </h1>

        <p>
            Overview of users, pet listings, and adoption applications across Furora.
        </p>

    </div>


    <!-- User Analytics -->

    <h2 class="section-title">
        User Overview
    </h2>


    <div class="analytics-grid">


        <div class="stat-card">

            <div class="stat-icon">
                👥
            </div>

            <div class="stat-number">
                ${requestScope.totalUsers}
            </div>

            <div class="stat-label">
                Total Users
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                🛡️
            </div>

            <div class="stat-number">
                ${requestScope.totalAdmins}
            </div>

            <div class="stat-label">
                Administrators
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                🏠
            </div>

            <div class="stat-number">
                ${requestScope.totalShelters}
            </div>

            <div class="stat-label">
                Shelters
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                ❤️
            </div>

            <div class="stat-number">
                ${requestScope.totalAdopters}
            </div>

            <div class="stat-label">
                Adopters
            </div>

        </div>


    </div>


    <!-- Pet Analytics -->

    <h2 class="section-title">
        Pet Listing Overview
    </h2>


    <div class="analytics-grid">


        <div class="stat-card">

            <div class="stat-icon">
                🐾
            </div>

            <div class="stat-number">
                ${requestScope.totalPets}
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
                ${requestScope.approvedPets}
            </div>

            <div class="stat-label">
                Approved Listings
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                ⏳
            </div>

            <div class="stat-number">
                ${requestScope.pendingPets}
            </div>

            <div class="stat-label">
                Pending Listings
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                ❌
            </div>

            <div class="stat-number">
                ${requestScope.rejectedPets}
            </div>

            <div class="stat-label">
                Rejected Listings
            </div>

        </div>


    </div>


    <!-- Application Analytics -->

    <h2 class="section-title">
        Adoption Application Overview
    </h2>


    <div class="analytics-grid">


        <div class="stat-card">

            <div class="stat-icon">
                📋
            </div>

            <div class="stat-number">
                ${requestScope.totalApplications}
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
                ${requestScope.pendingApplications}
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
                ${requestScope.approvedApplications}
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
                ${requestScope.rejectedApplications}
            </div>

            <div class="stat-label">
                Rejected Applications
            </div>

        </div>


    </div>


    <!-- Summary -->

    <div class="summary-card">

        <h2 class="section-title">
            Platform Summary
        </h2>


        <div class="summary-row">

            <span class="summary-name">
                Total registered users
            </span>

            <span class="summary-value">
                ${requestScope.totalUsers}
            </span>

        </div>


        <div class="summary-row">

            <span class="summary-name">
                Total pets listed
            </span>

            <span class="summary-value">
                ${requestScope.totalPets}
            </span>

        </div>


        <div class="summary-row">

            <span class="summary-name">
                Approved pets available for adoption
            </span>

            <span class="summary-value">
                ${requestScope.approvedPets}
            </span>

        </div>


        <div class="summary-row">

            <span class="summary-name">
                Total adoption applications
            </span>

            <span class="summary-value">
                ${requestScope.totalApplications}
            </span>

        </div>


        <div class="summary-row">

            <span class="summary-name">
                Approved adoption applications
            </span>

            <span class="summary-value">
                ${requestScope.approvedApplications}
            </span>

        </div>


    </div>


    <a
            href="admin-dashboard.jsp"
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