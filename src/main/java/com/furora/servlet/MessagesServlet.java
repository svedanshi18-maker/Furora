package com.furora.servlet;

import com.furora.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/messages")
public class MessagesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        int currentUserId =
                (Integer) session.getAttribute("userId");

        String otherUserIdParameter =
                request.getParameter("userId");

        if (otherUserIdParameter == null ||
                otherUserIdParameter.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "User ID is required."
            );

            return;
        }

        int otherUserId;

        try {

            otherUserId =
                    Integer.parseInt(otherUserIdParameter);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid user ID."
            );

            return;
        }

        List<Message> messages = new ArrayList<>();

        String sql =
                "SELECT m.id, m.sender_id, m.receiver_id, " +
                        "m.message, m.sent_at, " +
                        "u.name AS sender_name " +
                        "FROM messages m " +
                        "JOIN users u ON m.sender_id = u.id " +
                        "WHERE (m.sender_id = ? AND m.receiver_id = ?) " +
                        "OR (m.sender_id = ? AND m.receiver_id = ?) " +
                        "ORDER BY m.sent_at ASC";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, currentUserId);
            statement.setInt(2, otherUserId);
            statement.setInt(3, otherUserId);
            statement.setInt(4, currentUserId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    Message message = new Message(
                            resultSet.getInt("id"),
                            resultSet.getInt("sender_id"),
                            resultSet.getInt("receiver_id"),
                            resultSet.getString("message"),
                            resultSet.getTimestamp("sent_at"),
                            resultSet.getString("sender_name")
                    );

                    messages.add(message);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load messages."
            );

            return;
        }

        request.setAttribute(
                "messages",
                messages
        );

        request.setAttribute(
                "otherUserId",
                otherUserId
        );

        request.getRequestDispatcher(
                "/messages.jsp"
        ).forward(request, response);
    }


    public static class Message {

        private int id;
        private int senderId;
        private int receiverId;
        private String message;
        private java.sql.Timestamp sentAt;
        private String senderName;

        public Message(int id,
                       int senderId,
                       int receiverId,
                       String message,
                       java.sql.Timestamp sentAt,
                       String senderName) {

            this.id = id;
            this.senderId = senderId;
            this.receiverId = receiverId;
            this.message = message;
            this.sentAt = sentAt;
            this.senderName = senderName;
        }

        public int getId() {
            return id;
        }

        public int getSenderId() {
            return senderId;
        }

        public int getReceiverId() {
            return receiverId;
        }

        public String getMessage() {
            return message;
        }

        public java.sql.Timestamp getSentAt() {
            return sentAt;
        }

        public String getSenderName() {
            return senderName;
        }
    }
}