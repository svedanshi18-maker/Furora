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

@WebServlet("/edit-pet")
public class EditPetServlet extends HttpServlet {

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
                    "Only shelter users can edit pets."
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

            petId = Integer.parseInt(petIdParameter);

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
                "SELECT id, name, pet_type, age, breed, gender, " +
                        "location, description, photo, status " +
                        "FROM pets " +
                        "WHERE id = ? AND shelter_id = ?";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, petId);
            statement.setInt(2, shelterId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {

                    request.setAttribute(
                            "petId",
                            resultSet.getInt("id")
                    );

                    request.setAttribute(
                            "name",
                            resultSet.getString("name")
                    );

                    request.setAttribute(
                            "petType",
                            resultSet.getString("pet_type")
                    );

                    request.setAttribute(
                            "age",
                            resultSet.getInt("age")
                    );

                    request.setAttribute(
                            "breed",
                            resultSet.getString("breed")
                    );

                    request.setAttribute(
                            "gender",
                            resultSet.getString("gender")
                    );

                    request.setAttribute(
                            "location",
                            resultSet.getString("location")
                    );

                    request.setAttribute(
                            "description",
                            resultSet.getString("description")
                    );

                    request.setAttribute(
                            "photo",
                            resultSet.getString("photo")
                    );

                    request.setAttribute(
                            "status",
                            resultSet.getString("status")
                    );

                } else {

                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Pet not found or does not belong to this shelter."
                    );

                    return;
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load pet details."
            );

            return;
        }

        request.getRequestDispatcher(
                "/edit-pet.jsp"
        ).forward(request, response);
    }


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
                    "Only shelter users can edit pets."
            );

            return;
        }

        int shelterId =
                (Integer) session.getAttribute("userId");

        String petIdParameter =
                request.getParameter("petId");

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

        if (petIdParameter == null ||
                name == null ||
                name.trim().isEmpty() ||
                ageParameter == null ||
                ageParameter.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Pet ID, name, and age are required."
            );

            return;
        }

        int petId;
        int age;

        try {

            petId = Integer.parseInt(petIdParameter);
            age = Integer.parseInt(ageParameter);

            if (age < 0) {
                throw new NumberFormatException();
            }

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid pet ID or age."
            );

            return;
        }

        String sql =
                "UPDATE pets SET " +
                        "name = ?, pet_type = ?, age = ?, breed = ?, " +
                        "gender = ?, location = ?, description = ?, " +
                        "photo = ?, status = 'PENDING' " +
                        "WHERE id = ? AND shelter_id = ?";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, name.trim());
            statement.setString(
                    2,
                    petType == null ? "" : petType.trim()
            );
            statement.setInt(3, age);
            statement.setString(
                    4,
                    breed == null ? "" : breed.trim()
            );
            statement.setString(
                    5,
                    gender == null ? "" : gender.trim()
            );
            statement.setString(
                    6,
                    location == null ? "" : location.trim()
            );
            statement.setString(
                    7,
                    description == null ? "" : description.trim()
            );
            statement.setString(
                    8,
                    photo == null ? "" : photo.trim()
            );
            statement.setInt(9, petId);
            statement.setInt(10, shelterId);

            int rowsUpdated =
                    statement.executeUpdate();

            if (rowsUpdated == 0) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Pet not found or does not belong to this shelter."
                );

                return;
            }

            response.sendRedirect("shelter-pets");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to update pet."
            );
        }
    }
}