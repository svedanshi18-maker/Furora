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

@WebServlet("/send-message")
public class SendMessageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        int senderId =
                (Integer) session.getAttribute("userId");

        String receiverIdParameter =
                request.getParameter("receiverId");

        String message =
                request.getParameter("message");

        if (receiverIdParameter == null ||
                message == null ||
                message.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Receiver ID and message are required."
            );

            return;
        }

        int receiverId;

        try {

            receiverId =
                    Integer.parseInt(receiverIdParameter);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid receiver ID."
            );

            return;
        }

        if (receiverId == senderId) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "You cannot send a message to yourself."
            );

            return;
        }

        String sql =
                "INSERT INTO messages " +
                        "(sender_id, receiver_id, message) " +
                        "VALUES (?, ?, ?)";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, senderId);
            statement.setInt(2, receiverId);
            statement.setString(3, message.trim());

            statement.executeUpdate();

            response.sendRedirect(
                    "messages?userId=" + receiverId
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to send message."
            );
        }
    }
}