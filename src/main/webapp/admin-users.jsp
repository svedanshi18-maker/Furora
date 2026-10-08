<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>User Management - Furora</title>

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
            font-size: 34px;
            margin-bottom: 10px;
        }

        .heading p {
            color: #777;
        }

        .table-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 7px 20px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #6b4f3a;
            color: white;
            padding: 16px;
            text-align: left;
        }

        td {
            padding: 15px 16px;
            border-bottom: 1px solid #eee;
            color: #555;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:hover td {
            background: #fffaf5;
        }

        .role {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }

        .role-admin {
            background: #e8def8;
            color: #5a3d8a;
        }

        .role-shelter {
            background: #dceeff;
            color: #245b86;
        }

        .role-adopter {
            background: #dff3e4;
            color: #2f6b3b;
        }

        .actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-block;
            padding: 8px 14px;
            border-radius: 7px;
            text-decoration: none;
            font-size: 13px;
            font-weight: bold;
            border: none;
            cursor: pointer;
        }

        .edit-btn {
            background: #6b4f3a;
            color: white;
        }

        .edit-btn:hover {
            background: #543b2b;
        }

        .delete-btn {
            background: #b94a48;
            color: white;
        }

        .delete-btn:hover {
            background: #963c3a;
        }

        .empty {
            text-align: center;
            padding: 45px;
            color: #777;
        }

        .add-btn {
            display: inline-block;
            margin-bottom: 20px;
            padding: 11px 20px;
            background: #b06b3c;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: bold;
        }

        .add-btn:hover {
            background: #8f512d;
        }

        .back-btn {
            display: inline-block;
            margin-top: 25px;
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

            .table-card {
                overflow-x: auto;
            }

            table {
                min-width: 750px;
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
            User Management 👥
        </h1>

        <p>
            View and manage adopter, shelter, and administrator accounts.
        </p>

    </div>


    <!-- Create User Button -->

    <a
            href="create-user"
            class="add-btn">

        + Create New User

    </a>


    <%
        java.util.List<com.furora.servlet.AdminUsersServlet.User>
                users =
                (java.util.List<com.furora.servlet.AdminUsersServlet.User>)
                        request.getAttribute("users");
    %>


    <div class="table-card">


        <% if (users != null && !users.isEmpty()) { %>


            <table>

                <thead>

                <tr>

                    <th>
                        ID
                    </th>

                    <th>
                        Name
                    </th>

                    <th>
                        Email
                    </th>

                    <th>
                        Role
                    </th>

                    <th>
                        Actions
                    </th>

                </tr>

                </thead>


                <tbody>


                <% for (com.furora.servlet.AdminUsersServlet.User user
                        : users) { %>


                    <tr>

                        <td>
                            <%= user.getId() %>
                        </td>

                        <td>
                            <%= user.getName() %>
                        </td>

                        <td>
                            <%= user.getEmail() %>
                        </td>

                        <td>

                            <%
                                String role = user.getRole();

                                String roleClass = "role-adopter";

                                if ("ADMIN".equalsIgnoreCase(role)) {
                                    roleClass = "role-admin";
                                } else if ("SHELTER".equalsIgnoreCase(role)) {
                                    roleClass = "role-shelter";
                                }
                            %>

                            <span class="role <%= roleClass %>">
                                <%= role %>
                            </span>

                        </td>

                        <td>

                            <div class="actions">

                                <a
                                        href="edit-user?userId=<%= user.getId() %>"
                                        class="btn edit-btn">

                                    Edit

                                </a>


                                <a
                                        href="delete-user?userId=<%= user.getId() %>"
                                        class="btn delete-btn"
                                        onclick="return confirm('Are you sure you want to delete this user?');">

                                    Delete

                                </a>

                            </div>

                        </td>

                    </tr>


                <% } %>


                </tbody>

            </table>


        <% } else { %>


            <div class="empty">

                No users found.

            </div>


        <% } %>


    </div>


    <a
            href="admin-dashboard.jsp"
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