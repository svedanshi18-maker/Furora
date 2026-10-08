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

@WebServlet("/update-application-status")
public class UpdateApplicationStatusServlet extends HttpServlet {

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

        if (!"SHELTER".equalsIgnoreCase(role)) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Only shelter users can update applications."
            );

            return;
        }

        int shelterId =
                (Integer) session.getAttribute("userId");

        String applicationIdParameter =
                request.getParameter("applicationId");

        String status =
                request.getParameter("status");

        if (applicationIdParameter == null ||
                status == null) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Application ID and status are required."
            );

            return;
        }

        int applicationId;

        try {

            applicationId =
                    Integer.parseInt(applicationIdParameter);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid application ID."
            );

            return;
        }

        if (!"APPROVED".equalsIgnoreCase(status) &&
                !"REJECTED".equalsIgnoreCase(status)) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid application status."
            );

            return;
        }

        String checkSql =
                "SELECT a.id " +
                        "FROM adoption_applications a " +
                        "JOIN pets p ON a.pet_id = p.id " +
                        "WHERE a.id = ? AND p.shelter_id = ?";

        String updateSql =
                "UPDATE adoption_applications " +
                        "SET status = ? " +
                        "WHERE id = ?";

        try (Connection connection =
                     DBConnection.getConnection()) {

            try (PreparedStatement checkStatement =
                         connection.prepareStatement(checkSql)) {

                checkStatement.setInt(1, applicationId);
                checkStatement.setInt(2, shelterId);

                try (ResultSet resultSet =
                             checkStatement.executeQuery()) {

                    if (!resultSet.next()) {

                        response.sendError(
                                HttpServletResponse.SC_NOT_FOUND,
                                "Application not found for this shelter."
                        );

                        return;
                    }
                }
            }

            try (PreparedStatement updateStatement =
                         connection.prepareStatement(updateSql)) {

                updateStatement.setString(
                        1,
                        status.toUpperCase()
                );

                updateStatement.setInt(
                        2,
                        applicationId
                );

                int rowsUpdated =
                        updateStatement.executeUpdate();

                if (rowsUpdated == 0) {

                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Application not found."
                    );

                    return;
                }
            }

            response.sendRedirect(
                    "shelter-applications"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to update application status."
            );
        }
    }
}