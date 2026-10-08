<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Edit Pet - Furora</title>

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

        .page-container {
            width: 90%;
            max-width: 750px;
            margin: 45px auto;
        }

        .form-card {
            background: white;
            padding: 40px;
            border-radius: 18px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.10);
        }

        h1 {
            text-align: center;
            color: #4b3621;
            margin-bottom: 10px;
        }

        .subtitle {
            text-align: center;
            color: #777;
            margin-bottom: 30px;
        }

        .notice {
            background: #fff3cd;
            color: #856404;
            padding: 14px;
            border-radius: 8px;
            margin-bottom: 25px;
            line-height: 1.5;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #6b4f3a;
            font-weight: bold;
        }

        input,
        select,
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            font-family: Arial, sans-serif;
        }

        input:focus,
        select:focus,
        textarea:focus {
            outline: none;
            border-color: #b06b3c;
        }

        textarea {
            min-height: 130px;
            resize: vertical;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
        }

        .status-display {
            background: #f7f0e9;
            padding: 12px;
            border-radius: 8px;
            color: #6b4f3a;
            font-weight: bold;
        }

        .buttons {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }

        .save-btn,
        .cancel-btn {
            flex: 1;
            padding: 13px;
            border-radius: 25px;
            text-align: center;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .save-btn {
            border: none;
            background: #b06b3c;
            color: white;
        }

        .save-btn:hover {
            background: #8f512d;
        }

        .cancel-btn {
            background: #eee3d9;
            color: #6b4f3a;
        }

        .cancel-btn:hover {
            background: #e1d3c6;
        }

        footer {
            text-align: center;
            padding: 25px;
            margin-top: 60px;
            background: #4b3621;
            color: white;
        }

        @media (max-width: 650px) {

            header {
                padding: 20px;
                flex-direction: column;
                gap: 15px;
            }

            nav a {
                margin-left: 10px;
                margin-right: 10px;
            }

            .form-card {
                padding: 25px;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }

            .buttons {
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

        <a href="shelter-dashboard.jsp">
            Dashboard
        </a>

    </nav>

</header>


<main class="page-container">


    <div class="form-card">


        <h1>
            Edit Pet 🐾
        </h1>


        <p class="subtitle">
            Update the information about your pet listing.
        </p>


        <div class="notice">

            <strong>Important:</strong>
            After you update the pet information, the listing
            will be sent back to <strong>PENDING</strong> status
            and must be reviewed by an administrator again.

        </div>


        <form
                action="edit-pet"
                method="post">


            <input
                    type="hidden"
                    name="petId"
                    value="${petId}"
            >


            <div class="form-group">

                <label for="name">
                    Pet Name *
                </label>

                <input
                        type="text"
                        id="name"
                        name="name"
                        value="${name}"
                        required
                >

            </div>


            <div class="form-group">

                <label for="petType">
                    Pet Type
                </label>

                <select
                        id="petType"
                        name="petType">

                    <option value="">
                        Select pet type
                    </option>

                    <option
                            value="Dog"
                            ${petType == 'Dog' ? 'selected' : ''}>
                        Dog
                    </option>

                    <option
                            value="Cat"
                            ${petType == 'Cat' ? 'selected' : ''}>
                        Cat
                    </option>

                    <option
                            value="Rabbit"
                            ${petType == 'Rabbit' ? 'selected' : ''}>
                        Rabbit
                    </option>

                    <option
                            value="Bird"
                            ${petType == 'Bird' ? 'selected' : ''}>
                        Bird
                    </option>

                    <option
                            value="Other"
                            ${petType == 'Other' ? 'selected' : ''}>
                        Other
                    </option>

                </select>

            </div>


            <div class="form-row">


                <div class="form-group">

                    <label for="age">
                        Age (years) *
                    </label>

                    <input
                            type="number"
                            id="age"
                            name="age"
                            value="${age}"
                            min="0"
                            required
                    >

                </div>


                <div class="form-group">

                    <label for="gender">
                        Gender
                    </label>

                    <select
                            id="gender"
                            name="gender">

                        <option value="">
                            Select gender
                        </option>

                        <option
                                value="Male"
                                ${gender == 'Male' ? 'selected' : ''}>
                            Male
                        </option>

                        <option
                                value="Female"
                                ${gender == 'Female' ? 'selected' : ''}>
                            Female
                        </option>

                    </select>

                </div>


            </div>


            <div class="form-group">

                <label for="breed">
                    Breed
                </label>

                <input
                        type="text"
                        id="breed"
                        name="breed"
                        value="${breed}"
                        placeholder="e.g. Labrador"
                >

            </div>


            <div class="form-group">

                <label for="location">
                    Location
                </label>

                <input
                        type="text"
                        id="location"
                        name="location"
                        value="${location}"
                        placeholder="Enter pet location"
                >

            </div>


            <div class="form-group">

                <label for="photo">
                    Photo URL
                </label>

                <input
                        type="url"
                        id="photo"
                        name="photo"
                        value="${photo}"
                        placeholder="Enter direct image URL"
                >

            </div>


            <div class="form-group">

                <label for="description">
                    Description
                </label>

                <textarea
                        id="description"
                        name="description"
                        placeholder="Tell adopters about this pet..."
                >${description}</textarea>

            </div>


            <div class="form-group">

                <label>
                    Current Status
                </label>

                <div class="status-display">
                    ${status}
                </div>

            </div>


            <div class="buttons">


                <a
                        href="shelter-pets"
                        class="cancel-btn">

                    Cancel

                </a>


                <button
                        type="submit"
                        class="save-btn">

                    Save Changes

                </button>


            </div>


        </form>


    </div>


</main>


<footer>

    <p>
        © 2026 Furora | A New Beginning for Every Pet
    </p>

</footer>


</body>

</html>