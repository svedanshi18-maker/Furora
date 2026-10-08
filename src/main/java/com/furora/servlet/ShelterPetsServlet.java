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

@WebServlet("/shelter-pets")
public class ShelterPetsServlet extends HttpServlet {

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
                    "Only shelter users can view their pets."
            );

            return;
        }

        int shelterId =
                (Integer) session.getAttribute("userId");

        List<PetListing> pets = new ArrayList<>();

        String sql =
                "SELECT id, name, age, breed, gender, " +
                        "location, description, status " +
                        "FROM pets " +
                        "WHERE shelter_id = ? " +
                        "ORDER BY id DESC";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, shelterId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    PetListing pet =
                            new PetListing(
                                    resultSet.getInt("id"),
                                    resultSet.getString("name"),
                                    resultSet.getInt("age"),
                                    resultSet.getString("breed"),
                                    resultSet.getString("gender"),
                                    resultSet.getString("location"),
                                    resultSet.getString("description"),
                                    resultSet.getString("status")
                            );

                    pets.add(pet);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load shelter pets."
            );

            return;
        }

        request.setAttribute(
                "pets",
                pets
        );

        request.getRequestDispatcher(
                "/shelter-pets.jsp"
        ).forward(request, response);
    }


    public static class PetListing {

        private int id;
        private String name;
        private int age;
        private String breed;
        private String gender;
        private String location;
        private String description;
        private String status;

        public PetListing(
                int id,
                String name,
                int age,
                String breed,
                String gender,
                String location,
                String description,
                String status) {

            this.id = id;
            this.name = name;
            this.age = age;
            this.breed = breed;
            this.gender = gender;
            this.location = location;
            this.description = description;
            this.status = status;
        }

        public int getId() {
            return id;
        }

        public String getName() {
            return name;
        }

        public int getAge() {
            return age;
        }

        public String getBreed() {
            return breed;
        }

        public String getGender() {
            return gender;
        }

        public String getLocation() {
            return location;
        }

        public String getDescription() {
            return description;
        }

        public String getStatus() {
            return status;
        }
    }
}