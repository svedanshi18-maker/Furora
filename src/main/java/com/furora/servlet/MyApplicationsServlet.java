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

@WebServlet("/my-applications")
public class MyApplicationsServlet extends HttpServlet {

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

        int adopterId =
                (Integer) session.getAttribute("userId");

        List<Application> applications = new ArrayList<>();

        String sql =
                "SELECT a.id, a.pet_id, p.name AS pet_name, " +
                        "p.shelter_id, " +
                        "s.name AS shelter_name, " +
                        "a.message, a.status, a.application_date " +
                        "FROM adoption_applications a " +
                        "JOIN pets p ON a.pet_id = p.id " +
                        "LEFT JOIN users s ON p.shelter_id = s.id " +
                        "WHERE a.adopter_id = ? " +
                        "ORDER BY a.application_date DESC";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, adopterId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    Application application =
                            new Application(
                                    resultSet.getInt("id"),
                                    resultSet.getInt("pet_id"),
                                    resultSet.getString("pet_name"),
                                    resultSet.getInt("shelter_id"),
                                    resultSet.getString("shelter_name"),
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
                    "Unable to load applications."
            );

            return;
        }

        request.setAttribute(
                "applications",
                applications
        );

        request.getRequestDispatcher(
                "/my-applications.jsp"
        ).forward(request, response);
    }


    public static class Application {

        private int id;
        private int petId;
        private String petName;
        private int shelterId;
        private String shelterName;
        private String message;
        private String status;
        private java.sql.Timestamp applicationDate;

        public Application(
                int id,
                int petId,
                String petName,
                int shelterId,
                String shelterName,
                String message,
                String status,
                java.sql.Timestamp applicationDate) {

            this.id = id;
            this.petId = petId;
            this.petName = petName;
            this.shelterId = shelterId;
            this.shelterName = shelterName;
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

        public int getShelterId() {
            return shelterId;
        }

        public String getShelterName() {
            return shelterName;
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