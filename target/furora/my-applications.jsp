<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Applications - Furora</title>

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
            max-width: 1000px;
            margin: 45px auto;
        }

        h1 {
            color: #4b3621;
            margin-bottom: 10px;
        }

        .subtitle {
            color: #777;
            margin-bottom: 30px;
        }

        .application-card {
            background: white;
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 15px;
            box-shadow: 0 7px 20px rgba(0, 0, 0, 0.08);
        }

        .application-card h2 {
            margin-top: 0;
            color: #6b4f3a;
            margin-bottom: 15px;
        }

        .application-card p {
            margin: 10px 0;
            color: #555;
            line-height: 1.5;
        }

        .status {
            display: inline-block;
            padding: 7px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
            margin-top: 5px;
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

        .actions {
            margin-top: 20px;
        }

        .message-btn {
            display: inline-block;
            padding: 11px 20px;
            background: #b06b3c;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
        }

        .message-btn:hover {
            background: #8f512d;
        }

        .no-applications {
            background: white;
            padding: 45px;
            text-align: center;
            border-radius: 15px;
            box-shadow: 0 7px 20px rgba(0, 0, 0, 0.08);
        }

        .no-applications h2 {
            color: #6b4f3a;
            margin-bottom: 10px;
        }

        .no-applications p {
            color: #777;
            margin-bottom: 20px;
        }

        .browse-btn {
            display: inline-block;
            padding: 11px 20px;
            background: #6b4f3a;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
        }

        .browse-btn:hover {
            background: #543b2b;
        }

        .back-btn {
            display: inline-block;
            margin-top: 10px;
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

        @media (max-width: 650px) {

            header {
                padding: 20px;
                flex-direction: column;
                gap: 10px;
            }

            .container {
                width: 92%;
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


    <h1>
        My Adoption Applications
    </h1>

    <p class="subtitle">
        Track your applications and communicate with shelters.
    </p>


    <%
        java.util.List<com.furora.servlet.MyApplicationsServlet.Application>
                applications =
                (java.util.List<com.furora.servlet.MyApplicationsServlet.Application>)
                        request.getAttribute("applications");
    %>


    <% if (applications != null && !applications.isEmpty()) { %>


        <% for (com.furora.servlet.MyApplicationsServlet.Application app
                : applications) { %>


            <div class="application-card">


                <h2>
                    🐾 <%= app.getPetName() %>
                </h2>


                <p>
                    <strong>Application ID:</strong>
                    <%= app.getId() %>
                </p>


                <p>
                    <strong>Pet ID:</strong>
                    <%= app.getPetId() %>
                </p>


                <p>
                    <strong>Shelter:</strong>
                    <%= app.getShelterName() != null
                            ? app.getShelterName()
                            : "Shelter information unavailable" %>
                </p>


                <p>
                    <strong>Application Date:</strong>
                    <%= app.getApplicationDate() %>
                </p>


                <p>
                    <strong>Your Message:</strong>
                    <%= app.getMessage() %>
                </p>


                <p>

                    <strong>Status:</strong>

                    <%
                        String status = app.getStatus();

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


                <% if (app.getShelterId() > 0) { %>

                    <div class="actions">

                        <a
                                href="messages?userId=<%= app.getShelterId() %>"
                                class="message-btn">

                            💬 Message Shelter

                        </a>

                    </div>

                <% } %>


            </div>


        <% } %>


    <% } else { %>


        <div class="no-applications">

            <h2>
                No Applications Yet 🐾
            </h2>

            <p>
                You have not submitted any adoption applications yet.
            </p>

            <a
                    href="all-pets"
                    class="browse-btn">

                Browse Available Pets

            </a>

        </div>


    <% } %>


    <a
            href="adopter-dashboard.jsp"
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