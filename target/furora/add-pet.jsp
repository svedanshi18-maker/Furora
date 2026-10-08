<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Add Pet - Furora</title>

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
            max-width: 700px;
            margin: 45px auto;
        }

        .heading {
            text-align: center;
            margin-bottom: 30px;
        }

        .heading h1 {
            color: #4b3621;
            font-size: 34px;
            margin-bottom: 10px;
        }

        .heading p {
            color: #777;
        }

        .form-card {
            background: white;
            padding: 35px;
            border-radius: 16px;
            box-shadow: 0 7px 20px rgba(0,0,0,0.08);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #6b4f3a;
            font-weight: bold;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            font-family: Arial, sans-serif;
        }

        .form-group textarea {
            min-height: 120px;
            resize: vertical;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #b06b3c;
        }

        .hint {
            display: block;
            margin-top: 6px;
            color: #888;
            font-size: 13px;
        }

        .submit-btn {
            width: 100%;
            padding: 13px;
            border: none;
            border-radius: 8px;
            background: #b06b3c;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .submit-btn:hover {
            background: #8f512d;
        }

        .back-link {
            display: inline-block;
            margin-top: 18px;
            color: #6b4f3a;
            text-decoration: none;
            font-weight: bold;
        }

        .back-link:hover {
            color: #b06b3c;
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

            .form-card {
                padding: 25px;
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

        <a href="shelter-dashboard.jsp">
            Dashboard
        </a>

        <a href="shelter-pets">
            My Pets
        </a>

    </nav>

</header>


<main class="container">


    <div class="heading">

        <h1>
            Add a Pet 🐾
        </h1>

        <p>
            Add the details of a pet available for adoption.
        </p>

    </div>


    <div class="form-card">


        <form
                action="add-pet"
                method="post">


            <div class="form-group">

                <label for="name">
                    Pet Name
                </label>

                <input
                        type="text"
                        id="name"
                        name="name"
                        required>

            </div>


            <div class="form-group">

                <label for="petType">
                    Pet Type
                </label>

                <select
                        id="petType"
                        name="petType"
                        required>

                    <option value="">
                        Select Pet Type
                    </option>

                    <option value="Dog">
                        Dog
                    </option>

                    <option value="Cat">
                        Cat
                    </option>

                    <option value="Rabbit">
                        Rabbit
                    </option>

                    <option value="Bird">
                        Bird
                    </option>

                    <option value="Other">
                        Other
                    </option>

                </select>

            </div>


            <div class="form-group">

                <label for="age">
                    Age
                </label>

                <input
                        type="number"
                        id="age"
                        name="age"
                        min="0"
                        required>

            </div>


            <div class="form-group">

                <label for="breed">
                    Breed
                </label>

                <input
                        type="text"
                        id="breed"
                        name="breed">

            </div>


            <div class="form-group">

                <label for="gender">
                    Gender
                </label>

                <select
                        id="gender"
                        name="gender">

                    <option value="">
                        Select Gender
                    </option>

                    <option value="Male">
                        Male
                    </option>

                    <option value="Female">
                        Female
                    </option>

                </select>

            </div>


            <div class="form-group">

                <label for="location">
                    Location
                </label>

                <input
                        type="text"
                        id="location"
                        name="location">

            </div>


            <div class="form-group">

                <label for="description">
                    Description
                </label>

                <textarea
                        id="description"
                        name="description"
                        placeholder="Describe the pet..."></textarea>

            </div>


            <div class="form-group">

                <label for="photo">
                    Photo URL
                </label>

                <input
                        type="url"
                        id="photo"
                        name="photo"
                        placeholder="https://example.com/pet-photo.jpg">

                <span class="hint">
                    Enter the URL of the pet's photo.
                </span>

            </div>


            <button
                    type="submit"
                    class="submit-btn">

                Add Pet

            </button>


        </form>


        <a
                href="shelter-pets"
                class="back-link">

            ← Back to My Pets

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