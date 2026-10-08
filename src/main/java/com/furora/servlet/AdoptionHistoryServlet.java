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

@WebServlet("/adoption-history")
public class AdoptionHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
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

        if (!"ADOPTER".equalsIgnoreCase(role)) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Only adopters can view adoption history."
            );

            return;
        }

        int adopterId =
                (Integer) session.getAttribute("userId");

        List<Adoption> adoptions =
                new ArrayList<>();

        String sql =
                "SELECT aa.id AS application_id, " +
                        "p.name AS pet_name, " +
                        "p.pet_type, " +
                        "p.breed, " +
                        "p.location, " +
                        "aa.application_date, " +
                        "aa.status " +
                        "FROM adoption_applications aa " +
                        "JOIN pets p ON aa.pet_id = p.id " +
                        "WHERE aa.adopter_id = ? " +
                        "AND aa.status = 'APPROVED' " +
                        "ORDER BY aa.application_date DESC";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, adopterId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    Adoption adoption =
                            new Adoption(
                                    resultSet.getInt("application_id"),
                                    resultSet.getString("pet_name"),
                                    resultSet.getString("pet_type"),
                                    resultSet.getString("breed"),
                                    resultSet.getString("location"),
                                    resultSet.getTimestamp("application_date"),
                                    resultSet.getString("status")
                            );

                    adoptions.add(adoption);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load adoption history."
            );

            return;
        }

        request.setAttribute(
                "adoptions",
                adoptions
        );

        request.getRequestDispatcher(
                "/adoption-history.jsp"
        ).forward(request, response);
    }


    public static class Adoption {

        private int applicationId;
        private String petName;
        private String petType;
        private String breed;
        private String location;
        private java.sql.Timestamp applicationDate;
        private String status;

        public Adoption(int applicationId,
                        String petName,
                        String petType,
                        String breed,
                        String location,
                        java.sql.Timestamp applicationDate,
                        String status) {

            this.applicationId = applicationId;
            this.petName = petName;
            this.petType = petType;
            this.breed = breed;
            this.location = location;
            this.applicationDate = applicationDate;
            this.status = status;
        }

        public int getApplicationId() {
            return applicationId;
        }

        public String getPetName() {
            return petName;
        }

        public String getPetType() {
            return petType;
        }

        public String getBreed() {
            return breed;
        }

        public String getLocation() {
            return location;
        }

        public java.sql.Timestamp getApplicationDate() {
            return applicationDate;
        }

        public String getStatus() {
            return status;
        }
    }
}