<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>Apply for Adoption - Furora</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f7f4ef;
        }

        .header {
            background: #6b4f3a;
            color: white;
            padding: 20px 40px;
            text-align: center;
        }

        .header h1 {
            margin: 0;
        }

        .container {
            width: 90%;
            max-width: 650px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }

        h2 {
            color: #6b4f3a;
            margin-top: 0;
        }

        label {
            display: block;
            margin-top: 20px;
            margin-bottom: 8px;
            font-weight: bold;
            color: #444;
        }

        textarea {
            width: 100%;
            min-height: 150px;
            padding: 12px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-family: Arial, sans-serif;
            font-size: 15px;
            resize: vertical;
        }

        textarea:focus {
            outline: none;
            border-color: #6b4f3a;
        }

        .submit-btn {
            margin-top: 20px;
            padding: 12px 22px;
            border: none;
            border-radius: 7px;
            background: #6b4f3a;
            color: white;
            font-size: 15px;
            cursor: pointer;
        }

        .submit-btn:hover {
            background: #543b2b;
        }

        .back-btn {
            display: inline-block;
            margin-top: 15px;
            color: #6b4f3a;
            text-decoration: none;
        }

    </style>

</head>

<body>

<div class="header">

    <h1>🐾 Furora</h1>

</div>


<div class="container">

    <h2>Adoption Application</h2>

    <p>
        You are applying to adopt pet ID:
        <strong>${param.petId}</strong>
    </p>

    <form action="submit-application" method="post">

        <input
                type="hidden"
                name="petId"
                value="${param.petId}"
        >

        <label for="message">
            Why would you like to adopt this pet?
        </label>

        <textarea
                id="message"
                name="message"
                placeholder="Tell us why you would like to adopt this pet..."
                required
        ></textarea>

        <br>

        <button type="submit" class="submit-btn">
            Submit Application
        </button>

    </form>

    <a href="pet-details?id=${param.petId}" class="back-btn">
        ← Back to Pet Details
    </a>

</div>

</body>

</html>