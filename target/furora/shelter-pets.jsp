<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Pet Listings - Furora</title>

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

        .add-btn {
            display: inline-block;
            margin-bottom: 25px;
            padding: 12px 22px;
            background: #b06b3c;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: bold;
        }

        .add-btn:hover {
            background: #8f512d;
        }

        .pet-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
        }

        .pet-card {
            background: white;
            padding: 25px;
            border-radius: 16px;
            box-shadow: 0 7px 20px rgba(0, 0, 0, 0.08);
        }

        .pet-icon {
            font-size: 45px;
            margin-bottom: 10px;
        }

        .pet-card h2 {
            color: #6b4f3a;
            margin-bottom: 15px;
        }

        .pet-card p {
            color: #555;
            margin: 8px 0;
            line-height: 1.5;
        }

        .status {
            display: inline-block;
            padding: 7px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
            margin-top: 8px;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-approved {
            background: #d4edda;
            color: #155724;
        }

        .status-rejected {
            background: #f8d7da;
            color: #721c24;
        }

        .button-row {
            display: flex;
            gap: 10px;
            margin-top: 18px;
        }

        .edit-btn {
            display: inline-block;
            padding: 10px 20px;
            background: #6b4f3a;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
        }

        .edit-btn:hover {
            background: #543b2b;
        }

        .delete-btn {
            display: inline-block;
            padding: 10px 20px;
            background: #c0392b;
            color: white;
            text-decoration: none;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
        }

        .delete-btn:hover {
            background: #a93226;
        }

        .no-pets {
            background: white;
            padding: 50px;
            text-align: center;
            border-radius: 15px;
            box-shadow: 0 7px 20px rgba(0, 0, 0, 0.08);
        }

        .no-pets h2 {
            color: #6b4f3a;
            margin-bottom: 10px;
        }

        .no-pets p {
            color: #777;
            margin-bottom: 20px;
        }

        .back-btn {
            display: inline-block;
            margin-top: 30px;
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

        @media (max-width: 750px) {

            header {
                padding: 20px;
                flex-direction: column;
                gap: 10px;
            }

            .pet-grid {
                grid-template-columns: 1fr;
            }

            .button-row {
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

    <div class="welcome">
        Welcome, ${sessionScope.userName}!
    </div>

</header>


<main class="container">


    <div class="heading">

        <h1>
            My Pet Listings
        </h1>

        <p>
            View and manage the pets listed by your shelter.
        </p>

    </div>


    <!-- ADD NEW PET -->

    <a
            href="add-pet.jsp"
            class="add-btn">

        + Add New Pet

    </a>


    <%
        java.util.List<com.furora.servlet.ShelterPetsServlet.PetListing>
                pets =
                (java.util.List<com.furora.servlet.ShelterPetsServlet.PetListing>)
                        request.getAttribute("pets");
    %>


    <% if (pets != null && !pets.isEmpty()) { %>


        <div class="pet-grid">


            <% for (com.furora.servlet.ShelterPetsServlet.PetListing pet
                    : pets) { %>


                <div class="pet-card">


                    <div class="pet-icon">
                        🐾
                    </div>


                    <h2>
                        <%= pet.getName() %>
                    </h2>


                    <p>
                        <strong>Age:</strong>
                        <%= pet.getAge() %> years
                    </p>


                    <p>
                        <strong>Breed:</strong>
                        <%= pet.getBreed() != null
                                && !pet.getBreed().trim().isEmpty()
                                ? pet.getBreed()
                                : "Not specified" %>
                    </p>


                    <p>
                        <strong>Gender:</strong>
                        <%= pet.getGender() != null
                                && !pet.getGender().trim().isEmpty()
                                ? pet.getGender()
                                : "Not specified" %>
                    </p>


                    <p>
                        <strong>Location:</strong>
                        <%= pet.getLocation() != null
                                && !pet.getLocation().trim().isEmpty()
                                ? pet.getLocation()
                                : "Not specified" %>
                    </p>


                    <p>
                        <strong>Description:</strong>
                        <%= pet.getDescription() != null
                                && !pet.getDescription().trim().isEmpty()
                                ? pet.getDescription()
                                : "No description available." %>
                    </p>


                    <p>

                        <strong>Status:</strong>

                        <%
                            String status = pet.getStatus();

                            String statusClass = "status-pending";

                            if ("APPROVED".equalsIgnoreCase(status)) {
                                statusClass = "status-approved";
                            } else if ("REJECTED".equalsIgnoreCase(status)) {
                                statusClass = "status-rejected";
                            }
                        %>

                        <span class="status <%= statusClass %>">
                            <%= status %>
                        </span>

                    </p>


                    <!-- EDIT AND DELETE BUTTONS -->

                    <div class="button-row">

                        <a
                                href="edit-pet?petId=<%= pet.getId() %>"
                                class="edit-btn">

                            ✏️ Edit Pet

                        </a>


                        <form
                                action="delete-pet"
                                method="post"
                                style="display: inline;"
                                onsubmit="return confirm('Are you sure you want to delete this pet listing?');">

                            <input
                                    type="hidden"
                                    name="petId"
                                    value="<%= pet.getId() %>">

                            <button
                                    type="submit"
                                    class="delete-btn">

                                🗑️ Delete Pet

                            </button>

                        </form>

                    </div>


                </div>


            <% } %>


        </div>


    <% } else { %>


        <div class="no-pets">

            <h2>
                No Pet Listings Yet 🐾
            </h2>

            <p>
                Your shelter has not added any pets yet.
            </p>

            <!-- ADD FIRST PET -->

            <a
                    href="add-pet.jsp"
                    class="add-btn">

                Add Your First Pet

            </a>

        </div>


    <% } %>


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