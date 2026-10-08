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

@WebServlet("/submit-application")
public class SubmitApplicationServlet extends HttpServlet {

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

        String petIdParameter = request.getParameter("petId");
        String message = request.getParameter("message");

        if (petIdParameter == null || message == null ||
                message.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Pet ID and application message are required."
            );
            return;
        }

        int petId;
        int adopterId =
                (Integer) session.getAttribute("userId");

        try {

            petId = Integer.parseInt(petIdParameter);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid pet ID."
            );
            return;
        }

        String sql =
                "INSERT INTO adoption_applications " +
                        "(pet_id, adopter_id, message, status) " +
                        "VALUES (?, ?, ?, 'PENDING')";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, petId);
            statement.setInt(2, adopterId);
            statement.setString(3, message.trim());

            statement.executeUpdate();

            response.sendRedirect(
                    "application-success.jsp"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to submit application."
            );
        }
    }
}