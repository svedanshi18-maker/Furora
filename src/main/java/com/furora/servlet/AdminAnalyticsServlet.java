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

@WebServlet("/admin-analytics")
public class AdminAnalyticsServlet extends HttpServlet {

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

        String role =
                (String) session.getAttribute("userRole");

        if (!"ADMIN".equalsIgnoreCase(role)) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Only administrators can view platform analytics."
            );

            return;
        }

        int totalUsers = 0;
        int totalAdmins = 0;
        int totalShelters = 0;
        int totalAdopters = 0;

        int totalPets = 0;
        int approvedPets = 0;
        int pendingPets = 0;
        int rejectedPets = 0;

        int totalApplications = 0;
        int pendingApplications = 0;
        int approvedApplications = 0;
        int rejectedApplications = 0;

        String userSql =
                "SELECT " +
                        "COUNT(*) AS total_users, " +
                        "SUM(CASE WHEN role = 'ADMIN' THEN 1 ELSE 0 END) AS total_admins, " +
                        "SUM(CASE WHEN role = 'SHELTER' THEN 1 ELSE 0 END) AS total_shelters, " +
                        "SUM(CASE WHEN role = 'ADOPTER' THEN 1 ELSE 0 END) AS total_adopters " +
                        "FROM users";

        String petSql =
                "SELECT " +
                        "COUNT(*) AS total_pets, " +
                        "SUM(CASE WHEN status = 'APPROVED' THEN 1 ELSE 0 END) AS approved_pets, " +
                        "SUM(CASE WHEN status = 'PENDING' THEN 1 ELSE 0 END) AS pending_pets, " +
                        "SUM(CASE WHEN status = 'REJECTED' THEN 1 ELSE 0 END) AS rejected_pets " +
                        "FROM pets";

        String applicationSql =
                "SELECT " +
                        "COUNT(*) AS total_applications, " +
                        "SUM(CASE WHEN status = 'PENDING' THEN 1 ELSE 0 END) AS pending_applications, " +
                        "SUM(CASE WHEN status = 'APPROVED' THEN 1 ELSE 0 END) AS approved_applications, " +
                        "SUM(CASE WHEN status = 'REJECTED' THEN 1 ELSE 0 END) AS rejected_applications " +
                        "FROM adoption_applications";

        try (Connection connection =
                     DBConnection.getConnection()) {

            // User statistics
            try (PreparedStatement statement =
                         connection.prepareStatement(userSql);
                 ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {

                    totalUsers =
                            resultSet.getInt("total_users");

                    totalAdmins =
                            resultSet.getInt("total_admins");

                    totalShelters =
                            resultSet.getInt("total_shelters");

                    totalAdopters =
                            resultSet.getInt("total_adopters");
                }
            }


            // Pet statistics
            try (PreparedStatement statement =
                         connection.prepareStatement(petSql);
                 ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {

                    totalPets =
                            resultSet.getInt("total_pets");

                    approvedPets =
                            resultSet.getInt("approved_pets");

                    pendingPets =
                            resultSet.getInt("pending_pets");

                    rejectedPets =
                            resultSet.getInt("rejected_pets");
                }
            }


            // Adoption application statistics
            try (PreparedStatement statement =
                         connection.prepareStatement(applicationSql);
                 ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {

                    totalApplications =
                            resultSet.getInt("total_applications");

                    pendingApplications =
                            resultSet.getInt("pending_applications");

                    approvedApplications =
                            resultSet.getInt("approved_applications");

                    rejectedApplications =
                            resultSet.getInt("rejected_applications");
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load platform analytics."
            );

            return;
        }


        request.setAttribute(
                "totalUsers",
                totalUsers
        );

        request.setAttribute(
                "totalAdmins",
                totalAdmins
        );

        request.setAttribute(
                "totalShelters",
                totalShelters
        );

        request.setAttribute(
                "totalAdopters",
                totalAdopters
        );


        request.setAttribute(
                "totalPets",
                totalPets
        );

        request.setAttribute(
                "approvedPets",
                approvedPets
        );

        request.setAttribute(
                "pendingPets",
                pendingPets
        );

        request.setAttribute(
                "rejectedPets",
                rejectedPets
        );


        request.setAttribute(
                "totalApplications",
                totalApplications
        );

        request.setAttribute(
                "pendingApplications",
                pendingApplications
        );

        request.setAttribute(
                "approvedApplications",
                approvedApplications
        );

        request.setAttribute(
                "rejectedApplications",
                rejectedApplications
        );


        request.getRequestDispatcher(
                "/admin-analytics.jsp"
        ).forward(request, response);
    }
}