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

@WebServlet("/shelter-applications")
public class ShelterApplicationsServlet extends HttpServlet {

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

        if (!"SHELTER".equalsIgnoreCase(role)) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Only shelter users can manage applications."
            );

            return;
        }

        int shelterId =
                (Integer) session.getAttribute("userId");

        List<ShelterApplication> applications =
                new ArrayList<>();

        String sql =
                "SELECT a.id, a.pet_id, p.name AS pet_name, " +
                        "a.adopter_id, u.name AS adopter_name, " +
                        "u.email AS adopter_email, a.message, " +
                        "a.status, a.application_date " +
                        "FROM adoption_applications a " +
                        "JOIN pets p ON a.pet_id = p.id " +
                        "JOIN users u ON a.adopter_id = u.id " +
                        "WHERE p.shelter_id = ? " +
                        "ORDER BY a.application_date DESC";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, shelterId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    ShelterApplication application =
                            new ShelterApplication(
                                    resultSet.getInt("id"),
                                    resultSet.getInt("pet_id"),
                                    resultSet.getString("pet_name"),
                                    resultSet.getInt("adopter_id"),
                                    resultSet.getString("adopter_name"),
                                    resultSet.getString("adopter_email"),
                                    resultSet.getString("message"),
                                    resultSet.getString("status"),
                                    resultSet.getTimestamp("application_date")
                            );

                    applications.add(application);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load adoption applications."
            );

            return;
        }

        request.setAttribute(
                "applications",
                applications
        );

        request.getRequestDispatcher(
                "/shelter-applications.jsp"
        ).forward(request, response);
    }


    public static class ShelterApplication {

        private int id;
        private int petId;
        private String petName;
        private int adopterId;
        private String adopterName;
        private String adopterEmail;
        private String message;
        private String status;
        private java.sql.Timestamp applicationDate;

        public ShelterApplication(
                int id,
                int petId,
                String petName,
                int adopterId,
                String adopterName,
                String adopterEmail,
                String message,
                String status,
                java.sql.Timestamp applicationDate) {

            this.id = id;
            this.petId = petId;
            this.petName = petName;
            this.adopterId = adopterId;
            this.adopterName = adopterName;
            this.adopterEmail = adopterEmail;
            this.message = message;
            this.status = status;
            this.applicationDate = applicationDate;
        }

        public int getId() {
            return id;
        }

        public int getPetId() {
            return petId;
        }

        public String getPetName() {
            return petName;
        }

        public int getAdopterId() {
            return adopterId;
        }

        public String getAdopterName() {
            return adopterName;
        }

        public String getAdopterEmail() {
            return adopterEmail;
        }

        public String getMessage() {
            return message;
        }

        public String getStatus() {
            return status;
        }

        public java.sql.Timestamp getApplicationDate() {
            return applicationDate;
        }
    }
}