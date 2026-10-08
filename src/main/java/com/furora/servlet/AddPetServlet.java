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

@WebServlet("/add-pet")
public class AddPetServlet extends HttpServlet {

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
                    "Only shelters can add pets."
            );

            return;
        }

        int shelterId =
                (Integer) session.getAttribute("userId");

        String name =
                request.getParameter("name");

        String petType =
                request.getParameter("petType");

        String ageParameter =
                request.getParameter("age");

        String breed =
                request.getParameter("breed");

        String gender =
                request.getParameter("gender");

        String location =
                request.getParameter("location");

        String description =
                request.getParameter("description");

        String photo =
                request.getParameter("photo");


        if (name == null ||
                name.trim().isEmpty() ||
                ageParameter == null ||
                ageParameter.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Pet name and age are required."
            );

            return;
        }


        int age;

        try {

            age = Integer.parseInt(
                    ageParameter.trim()
            );

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Age must be a valid number."
            );

            return;
        }


        String sql =
                "INSERT INTO pets " +
                        "(name, pet_type, age, breed, gender, " +
                        "location, description, photo, status, shelter_id) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'PENDING', ?)";


        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(
                    1,
                    name.trim()
            );

            statement.setString(
                    2,
                    petType == null
                            ? ""
                            : petType.trim()
            );

            statement.setInt(
                    3,
                    age
            );

            statement.setString(
                    4,
                    breed == null
                            ? ""
                            : breed.trim()
            );

            statement.setString(
                    5,
                    gender == null
                            ? ""
                            : gender.trim()
            );

            statement.setString(
                    6,
                    location == null
                            ? ""
                            : location.trim()
            );

            statement.setString(
                    7,
                    description == null
                            ? ""
                            : description.trim()
            );

            statement.setString(
                    8,
                    photo == null
                            ? ""
                            : photo.trim()
            );

            statement.setInt(
                    9,
                    shelterId
            );

            statement.executeUpdate();

            response.sendRedirect(
                    "shelter-pets"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to add pet."
            );
        }
    }
}