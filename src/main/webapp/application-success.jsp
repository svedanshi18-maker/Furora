<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>Application Submitted - Furora</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f7f4ef;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .success-container {
            width: 90%;
            max-width: 550px;
            background: white;
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.10);
        }

        .icon {
            font-size: 60px;
            margin-bottom: 15px;
        }

        h1 {
            color: #6b4f3a;
        }

        p {
            color: #666;
            line-height: 1.6;
        }

        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 22px;
            background: #6b4f3a;
            color: white;
            text-decoration: none;
            border-radius: 7px;
        }

        .btn:hover {
            background: #543b2b;
        }

    </style>

</head>

<body>

<div class="success-container">

    <div class="icon">
        🐾
    </div>

    <h1>Application Submitted!</h1>

    <p>
        Your adoption application has been successfully submitted.
    </p>

    <p>
        The shelter will review your application and update
        its status once a decision has been made.
    </p>

    <a href="all-pets" class="btn">
        Browse More Pets
    </a>

    <br>

    <a href="adopter-dashboard.jsp" class="btn">
        Go to Dashboard
    </a>

</div>

</body>

</html>