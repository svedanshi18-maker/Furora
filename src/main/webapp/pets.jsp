<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Find a Pet - Furora</title>

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
            max-width: 1150px;
            margin: 45px auto;
        }

        .heading {
            text-align: center;
            margin-bottom: 30px;
        }

        .heading h1 {
            color: #4b3621;
            font-size: 36px;
            margin-bottom: 10px;
        }

        .heading p {
            color: #777;
        }

        .search-card {
            background: white;
            padding: 25px;
            border-radius: 16px;
            box-shadow: 0 7px 20px rgba(0, 0, 0, 0.08);
            margin-bottom: 35px;
        }

        .search-form {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
            align-items: end;
        }

        .form-group label {
            display: block;
            margin-bottom: 7px;
            color: #6b4f3a;
            font-weight: bold;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            background: white;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #b06b3c;
        }

        .search-btn {
            padding: 12px;
            border: none;
            border-radius: 8px;
            background: #b06b3c;
            color: white;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
        }

        .search-btn:hover {
            background: #8f512d;
        }

        .clear-btn {
            display: inline-block;
            margin-top: 15px;
            color: #6b4f3a;
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
        }

        .clear-btn:hover {
            color: #b06b3c;
        }

        .pets-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }

        .pet-card {
            background: white;
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 7px 20px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        .pet-photo {
            width: 100%;
            height: 220px;
            object-fit: cover;
            border-radius: 12px;
            margin-bottom: 18px;
            display: block;
        }

        .pet-icon {
            font-size: 55px;
            text-align: center;
            margin-bottom: 15px;
        }

        .pet-card h2 {
            color: #6b4f3a;
            margin-bottom: 12px;
        }

        .pet-info {
            color: #666;
            line-height: 1.7;
            margin-bottom: 18px;
        }

        .pet-info strong {
            color: #4b3621;
        }

        .view-btn {
            display: inline-block;
            padding: 10px 18px;
            background: #b06b3c;
            color: white;
            text-decoration: none;
            border-radius: 22px;
            font-weight: bold;
        }

        .view-btn:hover {
            background: #8f512d;
        }

        .empty {
            background: white;
            padding: 45px;
            border-radius: 16px;
            text-align: center;
            color: #777;
            box-shadow: 0 7px 20px rgba(0, 0, 0, 0.08);
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
                gap: 12px;
            }

            .search-form {
                grid-template-columns: repeat(2, 1fr);
            }

            .pets-grid {
                grid-template-columns: repeat(2, 1fr);
            }

        }

        @media (max-width: 600px) {

            .search-form {
                grid-template-columns: 1fr;
            }

            .pets-grid {
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

        <a href="adopter-dashboard.jsp">
            Dashboard
        </a>

    </nav>

</header>


<main class="container">


    <div class="heading">

        <h1>
            Find Your Perfect Companion 🐾
        </h1>

        <p>
            Search for pets by type, breed, and location.
        </p>

    </div>


    <!-- Search -->

    <div class="search-card">

        <form
                action="all-pets"
                method="get"
                class="search-form">


            <div class="form-group">

                <label for="petType">
                    Pet Type
                </label>

                <select
                        id="petType"
                        name="petType">

                    <option value="">
                        All Types
                    </option>

                    <option
                            value="Dog"
                            ${requestScope.petType == 'Dog' ? 'selected' : ''}>
                        Dog
                    </option>

                    <option
                            value="Cat"
                            ${requestScope.petType == 'Cat' ? 'selected' : ''}>
                        Cat
                    </option>

                    <option
                            value="Rabbit"
                            ${requestScope.petType == 'Rabbit' ? 'selected' : ''}>
                        Rabbit
                    </option>

                    <option
                            value="Bird"
                            ${requestScope.petType == 'Bird' ? 'selected' : ''}>
                        Bird
                    </option>

                    <option
                            value="Other"
                            ${requestScope.petType == 'Other' ? 'selected' : ''}>
                        Other
                    </option>

                </select>

            </div>


            <div class="form-group">

                <label for="breed">
                    Breed
                </label>

                <input
                        type="text"
                        id="breed"
                        name="breed"
                        value="${requestScope.breed}"
                        placeholder="e.g. Labrador">

            </div>


            <div class="form-group">

                <label for="location">
                    Location
                </label>

                <input
                        type="text"
                        id="location"
                        name="location"
                        value="${requestScope.location}"
                        placeholder="e.g. Prayagraj">

            </div>


            <button
                    type="submit"
                    class="search-btn">

                Search Pets

            </button>


        </form>


        <a
                href="all-pets"
                class="clear-btn">

            Clear Search

        </a>

    </div>


    <!-- Pet Results -->


    <%
        java.util.List<com.furora.model.Pet>
                pets =
                (java.util.List<com.furora.model.Pet>)
                        request.getAttribute("pets");
    %>


    <% if (pets != null && !pets.isEmpty()) { %>


        <div class="pets-grid">


            <% for (com.furora.model.Pet pet : pets) { %>


                <div class="pet-card">


                    <% if (pet.getPhoto() != null &&
                            !pet.getPhoto().trim().isEmpty()) { %>

                        <img
                                src="<%= pet.getPhoto() %>"
                                alt="<%= pet.getName() %>"
                                class="pet-photo">

                    <% } else { %>

                        <div class="pet-icon">
                            🐾
                        </div>

                    <% } %>


                    <h2>
                        <%= pet.getName() %>
                    </h2>


                    <div class="pet-info">

                        <div>
                            <strong>Type:</strong>
                            <%= pet.getPetType() == null
                                    ? "Not specified"
                                    : pet.getPetType() %>
                        </div>

                        <div>
                            <strong>Age:</strong>
                            <%= pet.getAge() %> years
                        </div>

                        <div>
                            <strong>Breed:</strong>
                            <%= pet.getBreed() == null
                                    ? "Not specified"
                                    : pet.getBreed() %>
                        </div>

                        <div>
                            <strong>Gender:</strong>
                            <%= pet.getGender() == null
                                    ? "Not specified"
                                    : pet.getGender() %>
                        </div>

                        <div>
                            <strong>Location:</strong>
                            <%= pet.getLocation() == null
                                    ? "Not specified"
                                    : pet.getLocation() %>
                        </div>

                    </div>


                    <a
                            href="pet-details?id=<%= pet.getId() %>"
                            class="view-btn">

                        View Details

                    </a>


                </div>


            <% } %>


        </div>


    <% } else { %>


        <div class="empty">

            <h2>
                No pets found
            </h2>

            <p>
                Try changing your search criteria.
            </p>

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