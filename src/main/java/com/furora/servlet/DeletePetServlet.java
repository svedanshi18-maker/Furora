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

@WebServlet("/delete-pet")
public class DeletePetServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        String role =
                (String) session.getAttribute("userRole");

        if (!"SHELTER".equalsIgnoreCase(role)) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Only shelters can delete pets."
            );

            return;
        }

        String petIdParameter =
                request.getParameter("petId");

        if (petIdParameter == null ||
                petIdParameter.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Pet ID is required."
            );

            return;
        }

        int petId;

        try {

            petId =
                    Integer.parseInt(
                            petIdParameter.trim()
                    );

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid pet ID."
            );

            return;
        }

        int shelterId =
                (Integer) session.getAttribute("userId");

        String sql =
                "DELETE FROM pets " +
                        "WHERE id = ? AND shelter_id = ?";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, petId);
            statement.setInt(2, shelterId);

            int rowsDeleted =
                    statement.executeUpdate();

            if (rowsDeleted == 0) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Pet not found or you are not authorized to delete it."
                );

                return;
            }

            response.sendRedirect("shelter-pets");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to delete pet. The pet may have existing adoption applications."
            );
        }
    }
}