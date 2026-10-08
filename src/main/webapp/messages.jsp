<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Messages - Furora</title>

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
            max-width: 850px;
            margin: 40px auto;
        }

        .page-title {
            text-align: center;
            margin-bottom: 30px;
        }

        .page-title h1 {
            color: #4b3621;
            font-size: 34px;
            margin-bottom: 8px;
        }

        .page-title p {
            color: #777;
        }

        .chat-box {
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.10);
            padding: 25px;
        }

        .messages {
            min-height: 300px;
            max-height: 500px;
            overflow-y: auto;
            padding: 10px;
            margin-bottom: 20px;
            background: #faf7f3;
            border-radius: 12px;
        }

        .message {
            margin-bottom: 15px;
            max-width: 75%;
            padding: 12px 15px;
            border-radius: 12px;
        }

        .my-message {
            margin-left: auto;
            background: #b06b3c;
            color: white;
            border-bottom-right-radius: 3px;
        }

        .other-message {
            margin-right: auto;
            background: #eee3d9;
            color: #4b3621;
            border-bottom-left-radius: 3px;
        }

        .sender {
            font-size: 12px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .message-text {
            line-height: 1.5;
            word-wrap: break-word;
        }

        .message-time {
            font-size: 11px;
            margin-top: 6px;
            opacity: 0.75;
        }

        .no-messages {
            text-align: center;
            padding: 100px 20px;
            color: #777;
        }

        .no-messages-icon {
            font-size: 50px;
            margin-bottom: 15px;
        }

        .send-form {
            display: flex;
            gap: 12px;
        }

        .send-form textarea {
            flex: 1;
            padding: 13px;
            border: 1px solid #ccc;
            border-radius: 10px;
            font-family: Arial, sans-serif;
            font-size: 15px;
            resize: none;
            min-height: 55px;
        }

        .send-form textarea:focus {
            outline: none;
            border-color: #b06b3c;
        }

        .send-btn {
            border: none;
            background: #b06b3c;
            color: white;
            padding: 0 25px;
            border-radius: 10px;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
        }

        .send-btn:hover {
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

        @media (max-width: 650px) {

            header {
                padding: 20px;
                flex-direction: column;
                gap: 10px;
            }

            .chat-box {
                padding: 15px;
            }

            .message {
                max-width: 85%;
            }

            .send-form {
                flex-direction: column;
            }

            .send-btn {
                padding: 13px;
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


    <div class="page-title">

        <h1>
            💬 Messages
        </h1>

        <p>
            Communicate with the other person regarding the adoption.
        </p>

    </div>


    <div class="chat-box">


        <div class="messages">

            <%
                java.util.List<com.furora.servlet.MessagesServlet.Message>
                        messages =
                        (java.util.List<com.furora.servlet.MessagesServlet.Message>)
                                request.getAttribute("messages");

                Integer currentUserId =
                        (Integer) session.getAttribute("userId");
            %>


            <% if (messages != null && !messages.isEmpty()) { %>


                <% for (com.furora.servlet.MessagesServlet.Message msg
                        : messages) { %>


                    <%
                        boolean isMyMessage =
                                msg.getSenderId() == currentUserId;
                    %>


                    <div class="message
                        <%= isMyMessage
                                ? "my-message"
                                : "other-message" %>">


                        <div class="sender">

                            <%= isMyMessage
                                    ? "You"
                                    : msg.getSenderName() %>

                        </div>


                        <div class="message-text">

                            <%= msg.getMessage() %>

                        </div>


                        <div class="message-time">

                            <%= msg.getSentAt() %>

                        </div>


                    </div>


                <% } %>


            <% } else { %>


                <div class="no-messages">

                    <div class="no-messages-icon">
                        💬
                    </div>

                    <h3>
                        No messages yet
                    </h3>

                    <p>
                        Start the conversation by sending a message.
                    </p>

                </div>


            <% } %>


        </div>


        <form
                action="send-message"
                method="post"
                class="send-form">


            <input
                    type="hidden"
                    name="receiverId"
                    value="${otherUserId}"
            >


            <textarea
                    name="message"
                    placeholder="Type your message..."
                    required
            ></textarea>


            <button
                    type="submit"
                    class="send-btn">

                Send

            </button>


        </form>


        <a
                href="index.html"
                class="back-btn">

            ← Back to Home

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