<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>${pet.name} - Furora</title>

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

        /* Header */

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
            margin-left: 30px;
            font-size: 16px;
        }

        nav a:hover {
            color: #b06b3c;
        }

        /* Main */

        .page-container {
            width: 90%;
            max-width: 1000px;
            margin: 50px auto;
        }

        .pet-card {
            background: white;
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.10);
            display: grid;
            grid-template-columns: 40% 60%;
        }

        /* Pet Image Area */

        .pet-image {
            background: linear-gradient(135deg, #fff0df, #f5d7bd);
            min-height: 430px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 150px;
        }

        /* Pet Information */

        .pet-info {
            padding: 45px;
        }

        .pet-info h1 {
            font-size: 40px;
            color: #4b3621;
            margin-bottom: 10px;
        }

        .pet-subtitle {
            color: #b06b3c;
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 30px;
        }

        .details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
            margin-bottom: 30px;
        }

        .detail-box {
            background: #fffaf5;
            padding: 15px;
            border-radius: 10px;
        }

        .detail-box strong {
            display: block;
            color: #6b4f3a;
            margin-bottom: 5px;
        }

        .detail-box span {
            color: #555;
        }

        .description-title {
            color: #6b4f3a;
            font-size: 20px;
            margin-bottom: 10px;
        }

        .description {
            color: #666;
            line-height: 1.7;
            margin-bottom: 30px;
        }

        /* Buttons */

        .actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .apply-btn {
            display: inline-block;
            padding: 13px 24px;
            background: #b06b3c;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: bold;
        }

        .apply-btn:hover {
            background: #8f512d;
        }

        .back-btn {
            display: inline-block;
            padding: 13px 24px;
            background: #eee3d9;
            color: #6b4f3a;
            text-decoration: none;
            border-radius: 25px;
            font-weight: bold;
        }

        .back-btn:hover {
            background: #e1d3c6;
        }

        /* Footer */

        footer {
            text-align: center;
            padding: 25px;
            margin-top: 60px;
            background: #4b3621;
            color: white;
        }

        /* Responsive */

        @media (max-width: 750px) {

            header {
                padding: 20px;
                flex-direction: column;
                gap: 15px;
            }

            nav a {
                margin-left: 10px;
                margin-right: 10px;
            }

            .pet-card {
                grid-template-columns: 1fr;
            }

            .pet-image {
                min-height: 280px;
                font-size: 110px;
            }

            .pet-info {
                padding: 30px;
            }

            .pet-info h1 {
                font-size: 32px;
            }

            .details {
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

    <div class="pet-card">


        <!-- Pet Image -->

        <div class="pet-image">
            🐾
        </div>


        <!-- Pet Information -->

        <div class="pet-info">

            <h1>
                ${pet.name}
            </h1>

            <div class="pet-subtitle">
                Looking for a loving forever home
            </div>


            <div class="details">

                <div class="detail-box">

                    <strong>
                        Age
                    </strong>

                    <span>
                        ${pet.age} years
                    </span>

                </div>


                <div class="detail-box">

                    <strong>
                        Breed
                    </strong>

                    <span>
                        ${pet.breed}
                    </span>

                </div>


                <div class="detail-box">

                    <strong>
                        Gender
                    </strong>

                    <span>
                        ${pet.gender}
                    </span>

                </div>


                <div class="detail-box">

                    <strong>
                        Location
                    </strong>

                    <span>
                        ${pet.location}
                    </span>

                </div>

            </div>


            <h2 class="description-title">
                About ${pet.name}
            </h2>

            <p class="description">
                ${pet.description}
            </p>


            <div class="actions">

                <a
                        href="apply-adoption?petId=${pet.id}"
                        class="apply-btn">
                    Apply for Adoption
                </a>

                <a
                        href="all-pets"
                        class="back-btn">
                    ← Back to Pets
                </a>

            </div>

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