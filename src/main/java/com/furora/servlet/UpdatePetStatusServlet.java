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

@WebServlet("/update-pet-status")
public class UpdatePetStatusServlet extends HttpServlet {

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

        String role =
                (String) session.getAttribute("userRole");

        if (!"ADMIN".equalsIgnoreCase(role)) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Only administrators can update pet listing status."
            );

            return;
        }

        String petIdParameter =
                request.getParameter("petId");

        String status =
                request.getParameter("status");

        if (petIdParameter == null ||
                status == null) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Pet ID and status are required."
            );

            return;
        }

        int petId;

        try {

            petId = Integer.parseInt(petIdParameter);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid pet ID."
            );

            return;
        }

        if (!"APPROVED".equalsIgnoreCase(status) &&
                !"REJECTED".equalsIgnoreCase(status)) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid pet status."
            );

            return;
        }

        String sql =
                "UPDATE pets SET status = ? " +
                        "WHERE id = ?";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(
                    1,
                    status.toUpperCase()
            );

            statement.setInt(2, petId);

            int rowsUpdated =
                    statement.executeUpdate();

            if (rowsUpdated == 0) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Pet listing not found."
                );

                return;
            }

            response.sendRedirect("admin-pets");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to update pet listing status."
            );
        }
    }
}