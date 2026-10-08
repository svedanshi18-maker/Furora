<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Pet Listing Management - Furora</title>

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
            width: 90%;
            max-width: 1100px;
            margin: 45px auto;
        }

        .heading {
            text-align: center;
            margin-bottom: 35px;
        }

        .heading h1 {
            color: #4b3621;
            font-size: 34px;
            margin-bottom: 10px;
        }

        .heading p {
            color: #777;
        }

        .pet-card {
            background: white;
            padding: 28px;
            margin-bottom: 25px;
            border-radius: 15px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
        }

        .pet-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .pet-header h2 {
            color: #6b4f3a;
        }

        .status {
            display: inline-block;
            padding: 7px 14px;
            border-radius: 20px;
            background: #fff3cd;
            color: #856404;
            font-size: 13px;
            font-weight: bold;
        }

        .details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
            margin-bottom: 18px;
        }

        .detail {
            background: #fffaf5;
            padding: 12px;
            border-radius: 8px;
        }

        .detail strong {
            display: block;
            color: #6b4f3a;
            margin-bottom: 4px;
        }

        .detail span {
            color: #555;
        }

        .description {
            margin: 18px 0;
            color: #666;
            line-height: 1.6;
        }

        .description strong {
            color: #6b4f3a;
        }

        .actions {
            display: flex;
            gap: 12px;
            margin-top: 20px;
        }

        .approve-btn,
        .reject-btn {
            padding: 11px 22px;
            border: none;
            border-radius: 25px;
            color: white;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }

        .approve-btn {
            background: #5d8a61;
        }

        .approve-btn:hover {
            background: #476d4b;
        }

        .reject-btn {
            background: #b05a5a;
        }

        .reject-btn:hover {
            background: #8f4141;
        }

        .empty-box {
            background: white;
            padding: 45px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
        }

        .empty-box h2 {
            color: #6b4f3a;
            margin-bottom: 10px;
        }

        .empty-box p {
            color: #777;
        }

        .back-btn {
            display: inline-block;
            margin-top: 30px;
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

            .details {
                grid-template-columns: 1fr;
            }

            .pet-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .actions {
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


<main class="container">

    <div class="heading">

        <h1>
            Pet Listing Management
        </h1>

        <p>
            Review shelter pet listings waiting for approval.
        </p>

    </div>


    <%
        java.util.List<com.furora.servlet.AdminPetsServlet.PetListing>
                pets =
                (java.util.List<com.furora.servlet.AdminPetsServlet.PetListing>)
                        request.getAttribute("pets");
    %>


    <% if (pets != null && !pets.isEmpty()) { %>


        <% for (com.furora.servlet.AdminPetsServlet.PetListing pet
                : pets) { %>


            <div class="pet-card">


                <div class="pet-header">

                    <h2>
                        🐾 <%= pet.getName() %>
                    </h2>

                    <span class="status">
                        <%= pet.getStatus() %>
                    </span>

                </div>


                <div class="details">

                    <div class="detail">

                        <strong>
                            Pet ID
                        </strong>

                        <span>
                            <%= pet.getId() %>
                        </span>

                    </div>


                    <div class="detail">

                        <strong>
                            Age
                        </strong>

                        <span>
                            <%= pet.getAge() %> years
                        </span>

                    </div>


                    <div class="detail">

                        <strong>
                            Breed
                        </strong>

                        <span>
                            <%= pet.getBreed() %>
                        </span>

                    </div>


                    <div class="detail">

                        <strong>
                            Gender
                        </strong>

                        <span>
                            <%= pet.getGender() %>
                        </span>

                    </div>


                    <div class="detail">

                        <strong>
                            Location
                        </strong>

                        <span>
                            <%= pet.getLocation() %>
                        </span>

                    </div>


                    <div class="detail">

                        <strong>
                            Shelter
                        </strong>

                        <span>
                            <%= pet.getShelterName() %>
                        </span>

                    </div>

                </div>


                <div class="description">

                    <strong>
                        Description:
                    </strong>

                    <%= pet.getDescription() %>

                </div>


                <div class="actions">

                    <form action="update-pet-status"
                          method="post">

                        <input type="hidden"
                               name="petId"
                               value="<%= pet.getId() %>">

                        <input type="hidden"
                               name="status"
                               value="APPROVED">

                        <button type="submit"
                                class="approve-btn">
                            ✓ Approve
                        </button>

                    </form>


                    <form action="update-pet-status"
                          method="post">

                        <input type="hidden"
                               name="petId"
                               value="<%= pet.getId() %>">

                        <input type="hidden"
                               name="status"
                               value="REJECTED">

                        <button type="submit"
                                class="reject-btn">
                            ✕ Reject
                        </button>

                    </form>

                </div>


            </div>


        <% } %>


    <% } else { %>


        <div class="empty-box">

            <h2>
                No Pending Listings 🎉
            </h2>

            <p>
                There are currently no pet listings waiting for approval.
            </p>

        </div>


    <% } %>


    <div style="text-align: center;">

        <a href="admin-dashboard.jsp"
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