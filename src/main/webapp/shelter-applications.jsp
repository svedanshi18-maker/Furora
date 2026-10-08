<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Applications - Furora</title>

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

        .application-card {
            background: white;
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 15px;
            box-shadow: 0 7px 20px rgba(0, 0, 0, 0.08);
        }

        .application-card h2 {
            color: #6b4f3a;
            margin-bottom: 15px;
        }

        .application-card p {
            margin: 9px 0;
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
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        .action-form {
            display: inline;
        }

        .btn {
            border: none;
            padding: 10px 18px;
            border-radius: 8px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }

        .approve-btn {
            background: #4f8a5b;
        }

        .approve-btn:hover {
            background: #3d7048;
        }

        .reject-btn {
            background: #b94a48;
        }

        .reject-btn:hover {
            background: #963c3a;
        }

        .message-btn {
            background: #b06b3c;
        }

        .message-btn:hover {
            background: #8f512d;
        }

        .back-btn {
            display: inline-block;
            margin-top: 15px;
            padding: 11px 20px;
            background: #6b4f3a;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
        }

        .back-btn:hover {
            background: #543b2b;
        }

        .no-applications {
            background: white;
            padding: 50px;
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

            .actions {
                flex-direction: column;
            }

            .btn {
                text-align: center;
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
            Adoption Applications
        </h1>

        <p>
            Review applications and communicate with adopters.
        </p>

    </div>


    <%
        java.util.List<com.furora.servlet.ShelterApplicationsServlet.ShelterApplication>
                applications =
                (java.util.List<com.furora.servlet.ShelterApplicationsServlet.ShelterApplication>)
                        request.getAttribute("applications");
    %>


    <% if (applications != null && !applications.isEmpty()) { %>


        <% for (com.furora.servlet.ShelterApplicationsServlet.ShelterApplication app
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
                    <strong>Adopter:</strong>
                    <%= app.getAdopterName() %>
                </p>


                <p>
                    <strong>Email:</strong>
                    <%= app.getAdopterEmail() %>
                </p>


                <p>
                    <strong>Application Date:</strong>
                    <%= app.getApplicationDate() %>
                </p>


                <p>
                    <strong>Message:</strong>
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


                <div class="actions">


                    <% if ("PENDING".equalsIgnoreCase(status)) { %>


                        <form
                                action="update-application-status"
                                method="post"
                                class="action-form">

                            <input
                                    type="hidden"
                                    name="applicationId"
                                    value="<%= app.getId() %>"
                            >

                            <input
                                    type="hidden"
                                    name="status"
                                    value="APPROVED"
                            >

                            <button
                                    type="submit"
                                    class="btn approve-btn">

                                ✓ Approve Application

                            </button>

                        </form>


                        <form
                                action="update-application-status"
                                method="post"
                                class="action-form">

                            <input
                                    type="hidden"
                                    name="applicationId"
                                    value="<%= app.getId() %>"
                            >

                            <input
                                    type="hidden"
                                    name="status"
                                    value="REJECTED"
                            >

                            <button
                                    type="submit"
                                    class="btn reject-btn">

                                ✕ Reject Application

                            </button>

                        </form>


                    <% } %>


                    <a
                            href="messages?userId=<%= app.getAdopterId() %>"
                            class="btn message-btn">

                        💬 Message Adopter

                    </a>


                </div>


            </div>


        <% } %>


    <% } else { %>


        <div class="no-applications">

            <h2>
                No Applications Yet
            </h2>

            <p>
                There are currently no adoption applications
                for your shelter's pets.
            </p>

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