<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.furora.servlet.AdoptionHistoryServlet.Adoption" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Adoption History - Furora</title>

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

        .container {
            width: 92%;
            max-width: 1100px;
            margin: 45px auto;
        }

        .heading {
            text-align: center;
            margin-bottom: 35px;
        }

        .heading h1 {
            color: #4b3621;
            font-size: 36px;
            margin-bottom: 10px;
        }

        .heading p {
            color: #777;
        }

        .history-card {
            background: white;
            border-radius: 16px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 7px 20px rgba(0, 0, 0, 0.08);
        }

        .history-card h2 {
            color: #6b4f3a;
            margin-bottom: 18px;
        }

        .details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
            margin-bottom: 20px;
        }

        .detail {
            color: #666;
            line-height: 1.5;
        }

        .detail strong {
            color: #4b3621;
        }

        .status {
            display: inline-block;
            padding: 7px 14px;
            border-radius: 20px;
            background: #e7f5e8;
            color: #26733a;
            font-weight: bold;
            font-size: 14px;
        }

        .empty {
            background: white;
            padding: 50px 25px;
            border-radius: 16px;
            text-align: center;
            box-shadow: 0 7px 20px rgba(0, 0, 0, 0.08);
        }

        .empty h2 {
            color: #6b4f3a;
            margin-bottom: 12px;
        }

        .empty p {
            color: #777;
            margin-bottom: 20px;
        }

        .dashboard-btn {
            display: inline-block;
            padding: 11px 20px;
            background: #b06b3c;
            color: white;
            text-decoration: none;
            border-radius: 22px;
            font-weight: bold;
        }

        .dashboard-btn:hover {
            background: #8f512d;
        }

        footer {
            text-align: center;
            padding: 25px;
            margin-top: 60px;
            background: #4b3621;
            color: white;
        }

        @media (max-width: 600px) {

            header {
                padding: 20px;
                flex-direction: column;
                gap: 12px;
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

        <a href="adopter-dashboard.jsp">
            Dashboard
        </a>

        <a href="all-pets">
            Browse Pets
        </a>

    </nav>

</header>


<main class="container">


    <div class="heading">

        <h1>
            Adoption History
        </h1>

        <p>
            Pets whose adoption applications have been approved.
        </p>

    </div>


    <%
        List<Adoption> adoptions =
                (List<Adoption>) request.getAttribute("adoptions");
    %>


    <% if (adoptions != null && !adoptions.isEmpty()) { %>


        <% for (Adoption adoption : adoptions) { %>


            <div class="history-card">


                <h2>
                    <%= adoption.getPetName() %>
                </h2>


                <div class="details">


                    <div class="detail">

                        <strong>
                            Application ID:
                        </strong>

                        <%= adoption.getApplicationId() %>

                    </div>


                    <div class="detail">

                        <strong>
                            Pet Type:
                        </strong>

                        <%= adoption.getPetType() == null
                                ? "Not specified"
                                : adoption.getPetType() %>

                    </div>


                    <div class="detail">

                        <strong>
                            Breed:
                        </strong>

                        <%= adoption.getBreed() == null
                                ? "Not specified"
                                : adoption.getBreed() %>

                    </div>


                    <div class="detail">

                        <strong>
                            Location:
                        </strong>

                        <%= adoption.getLocation() == null
                                ? "Not specified"
                                : adoption.getLocation() %>

                    </div>


                    <div class="detail">

                        <strong>
                            Application Date:
                        </strong>

                        <%= adoption.getApplicationDate() %>

                    </div>


                </div>


                <span class="status">

                    <%= adoption.getStatus() %>

                </span>


            </div>


        <% } %>


    <% } else { %>


        <div class="empty">

            <h2>
                No Adoption History Yet
            </h2>

            <p>
                You don't have any approved adoptions yet.
            </p>

            <a
                    href="all-pets"
                    class="dashboard-btn">

                Browse Pets

            </a>

        </div>


    <% } %>


</main>


<footer>

    <p>
        © 2026 Furora | A New Beginning for Every Pet
    </p>

</footer>


</body>

</html>