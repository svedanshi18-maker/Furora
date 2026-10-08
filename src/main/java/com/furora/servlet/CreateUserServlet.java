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

@WebServlet("/create-user")
public class CreateUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) {
            return;
        }

        request.getRequestDispatcher(
                "/create-user.jsp"
        ).forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) {
            return;
        }

        String name =
                request.getParameter("name");

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        String role =
                request.getParameter("role");

        if (name == null ||
                name.trim().isEmpty() ||
                email == null ||
                email.trim().isEmpty() ||
                password == null ||
                password.trim().isEmpty() ||
                role == null ||
                role.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Name, email, password, and role are required."
            );

            return;
        }

        role = role.trim().toUpperCase();

        if (!"ADMIN".equals(role) &&
                !"SHELTER".equals(role) &&
                !"ADOPTER".equals(role)) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid user role."
            );

            return;
        }

        String checkSql =
                "SELECT id FROM users WHERE email = ?";

        String insertSql =
                "INSERT INTO users " +
                        "(name, email, password, role) " +
                        "VALUES (?, ?, ?, ?)";

        try (Connection connection =
                     DBConnection.getConnection()) {

            // Check whether the email already exists.

            try (PreparedStatement checkStatement =
                         connection.prepareStatement(checkSql)) {

                checkStatement.setString(
                        1,
                        email.trim()
                );

                try (ResultSet resultSet =
                             checkStatement.executeQuery()) {

                    if (resultSet.next()) {

                        response.sendError(
                                HttpServletResponse.SC_CONFLICT,
                                "A user with this email already exists."
                        );

                        return;
                    }
                }
            }


            // Create the new user.

            try (PreparedStatement insertStatement =
                         connection.prepareStatement(insertSql)) {

                insertStatement.setString(
                        1,
                        name.trim()
                );

                insertStatement.setString(
                        2,
                        email.trim()
                );

                insertStatement.setString(
                        3,
                        password
                );

                insertStatement.setString(
                        4,
                        role
                );

                insertStatement.executeUpdate();
            }

            response.sendRedirect("admin-users");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to create user."
            );
        }
    }


    private boolean isAdmin(HttpServletRequest request,
                            HttpServletResponse response)
            throws IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect("login.jsp");
            return false;
        }

        String role =
                (String) session.getAttribute("userRole");

        if (!"ADMIN".equalsIgnoreCase(role)) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Only administrators can create users."
            );

            return false;
        }

        return true;
    }
}