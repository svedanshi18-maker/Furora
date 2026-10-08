<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Shelter Dashboard - Furora</title>

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
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
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

        .container {
            width: 92%;
            max-width: 1100px;
            margin: 50px auto;
        }

        .welcome {
            text-align: center;
            margin-bottom: 40px;
        }

        .welcome h1 {
            color: #4b3621;
            font-size: 36px;
            margin-bottom: 10px;
        }

        .welcome p {
            color: #777;
            font-size: 16px;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
        }

        .card {
            background: white;
            padding: 35px 25px;
            border-radius: 16px;
            text-align: center;
            box-shadow: 0 7px 20px rgba(0,0,0,0.08);
            transition: transform 0.2s;
        }

        .card:hover {
            transform: translateY(-4px);
        }

        .icon {
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
            border-radius: 22px;
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

        @media (max-width: 700px) {

            header {
                padding: 20px;
                flex-direction: column;
                gap: 12px;
            }

            .cards {
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

    <nav>
        <a href="index.html">Home</a>
    </nav>

</header>


<main class="container">


    <div class="welcome">

        <h1>
            Welcome, ${sessionScope.userName}! 🐾
        </h1>

        <p>
            Manage your pets, adoption applications,
            communication, and adoption statistics.
        </p>

    </div>


    <div class="cards">


        <!-- 1. PET LISTINGS -->

        <div class="card">

            <div class="icon">
                🐾
            </div>

            <h2>
                Pet Listings
            </h2>

            <p>
                Add, edit, and update your pet listings.
            </p>

            <a href="shelter-pets" class="btn">
                Manage Pet Listings
            </a>

            <br><br>

            <!-- IMPORTANT: This opens the JSP form -->
            <a href="add-pet.jsp" class="btn">
                Add Pet
            </a>

        </div>


        <!-- 2. APPLICATIONS -->

        <div class="card">

            <div class="icon">
                📋
            </div>

            <h2>
                Applications
            </h2>

            <p>
                Review adoption applications and update their status.
            </p>

            <a href="shelter-applications" class="btn">
                Manage Applications
            </a>

        </div>


        <!-- 3. COMMUNICATION -->

        <div class="card">

            <div class="icon">
                💬
            </div>

            <h2>
                Communication
            </h2>

            <p>
                Communicate with adopters about adoption applications.
            </p>

            <a href="messages" class="btn">
                Messages
            </a>

        </div>


        <!-- 4. ADOPTION STATISTICS -->

        <div class="card">

            <div class="icon">
                📊
            </div>

            <h2>
                Adoption Statistics
            </h2>

            <p>
                View your pet and adoption application statistics.
            </p>

            <a href="shelter-statistics" class="btn">
                View Statistics
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