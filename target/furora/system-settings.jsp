<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>System Settings - Furora</title>

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
            max-width: 950px;
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
            line-height: 1.5;
        }

        .settings-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 7px 20px rgba(0, 0, 0, 0.08);
            padding: 30px;
        }

        .setting {
            padding: 25px 0;
            border-bottom: 1px solid #eee;
        }

        .setting:first-child {
            padding-top: 0;
        }

        .setting:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }

        .setting-header {
            margin-bottom: 15px;
        }

        .setting-name {
            font-size: 18px;
            font-weight: bold;
            color: #6b4f3a;
            margin-bottom: 5px;
        }

        .setting-id {
            font-size: 12px;
            color: #999;
        }

        .setting-form {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .setting-form input {
            flex: 1;
            padding: 12px 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
        }

        .setting-form input:focus {
            outline: none;
            border-color: #b06b3c;
        }

        .save-btn {
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            background: #b06b3c;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }

        .save-btn:hover {
            background: #8f512d;
        }

        .empty {
            text-align: center;
            padding: 45px;
            color: #777;
        }

        .info-box {
            margin-top: 25px;
            background: #fff3e6;
            color: #795548;
            padding: 15px;
            border-radius: 9px;
            line-height: 1.5;
            font-size: 14px;
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

        @media (max-width: 650px) {

            header {
                padding: 20px;
                flex-direction: column;
                gap: 10px;
            }

            .settings-card {
                padding: 20px;
            }

            .setting-form {
                flex-direction: column;
                align-items: stretch;
            }

            .save-btn {
                width: 100%;
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
            System Settings ⚙️
        </h1>

        <p>
            Manage configuration settings for the Furora platform.
        </p>

    </div>


    <%
        java.util.List<com.furora.servlet.SystemSettingsServlet.Setting>
                settings =
                (java.util.List<com.furora.servlet.SystemSettingsServlet.Setting>)
                        request.getAttribute("settings");
    %>


    <div class="settings-card">


        <% if (settings != null && !settings.isEmpty()) { %>


            <% for (com.furora.servlet.SystemSettingsServlet.Setting setting
                    : settings) { %>


                <div class="setting">


                    <div class="setting-header">

                        <div class="setting-name">
                            <%= setting.getName() %>
                        </div>

                        <div class="setting-id">
                            Setting ID: <%= setting.getId() %>
                        </div>

                    </div>


                    <form
                            action="system-settings"
                            method="post"
                            class="setting-form">


                        <input
                                type="hidden"
                                name="settingId"
                                value="<%= setting.getId() %>"
                        >


                        <input
                                type="text"
                                name="settingValue"
                                value="<%= setting.getValue() == null
                                        ? ""
                                        : setting.getValue() %>"
                                required
                        >


                        <button
                                type="submit"
                                class="save-btn">

                            Save

                        </button>


                    </form>


                </div>


            <% } %>


        <% } else { %>


            <div class="empty">

                No system settings have been configured yet.

            </div>


        <% } %>


    </div>


    <div class="info-box">

        <strong>Admin notice:</strong>
        Changes made here affect the configuration values stored
        for the Furora platform. Review a value before saving it.

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