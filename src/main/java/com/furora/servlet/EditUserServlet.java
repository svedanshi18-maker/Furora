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

@WebServlet("/edit-user")
public class EditUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) {
            return;
        }

        String userIdParameter =
                request.getParameter("userId");

        if (userIdParameter == null ||
                userIdParameter.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "User ID is required."
            );

            return;
        }

        int userId;

        try {

            userId = Integer.parseInt(userIdParameter);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid user ID."
            );

            return;
        }

        String sql =
                "SELECT id, name, email, role " +
                        "FROM users WHERE id = ?";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {

                    request.setAttribute(
                            "userId",
                            resultSet.getInt("id")
                    );

                    request.setAttribute(
                            "name",
                            resultSet.getString("name")
                    );

                    request.setAttribute(
                            "email",
                            resultSet.getString("email")
                    );

                    request.setAttribute(
                            "role",
                            resultSet.getString("role")
                    );

                } else {

                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "User not found."
                    );

                    return;
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load user details."
            );

            return;
        }

        request.getRequestDispatcher(
                "/edit-user.jsp"
        ).forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) {
            return;
        }

        String userIdParameter =
                request.getParameter("userId");

        String name =
                request.getParameter("name");

        String email =
                request.getParameter("email");

        String role =
                request.getParameter("role");

        if (userIdParameter == null ||
                name == null ||
                name.trim().isEmpty() ||
                email == null ||
                email.trim().isEmpty() ||
                role == null ||
                role.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "User ID, name, email, and role are required."
            );

            return;
        }

        int userId;

        try {

            userId =
                    Integer.parseInt(userIdParameter);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid user ID."
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

        String checkEmailSql =
                "SELECT id FROM users " +
                        "WHERE email = ? AND id <> ?";

        String updateSql =
                "UPDATE users " +
                        "SET name = ?, email = ?, role = ? " +
                        "WHERE id = ?";

        try (Connection connection =
                     DBConnection.getConnection()) {

            // Check whether another user already has this email.
            try (PreparedStatement checkStatement =
                         connection.prepareStatement(checkEmailSql)) {

                checkStatement.setString(
                        1,
                        email.trim()
                );

                checkStatement.setInt(
                        2,
                        userId
                );

                try (ResultSet resultSet =
                             checkStatement.executeQuery()) {

                    if (resultSet.next()) {

                        response.sendError(
                                HttpServletResponse.SC_CONFLICT,
                                "Another user already uses this email address."
                        );

                        return;
                    }
                }
            }

            // Update the user.
            try (PreparedStatement updateStatement =
                         connection.prepareStatement(updateSql)) {

                updateStatement.setString(
                        1,
                        name.trim()
                );

                updateStatement.setString(
                        2,
                        email.trim()
                );

                updateStatement.setString(
                        3,
                        role
                );

                updateStatement.setInt(
                        4,
                        userId
                );

                int rowsUpdated =
                        updateStatement.executeUpdate();

                if (rowsUpdated == 0) {

                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "User not found."
                    );

                    return;
                }
            }

            // If the admin edited their own name,
            // keep the session welcome message updated.
            HttpSession session =
                    request.getSession(false);

            if (session != null) {

                Integer loggedInUserId =
                        (Integer) session.getAttribute("userId");

                if (loggedInUserId != null &&
                        loggedInUserId == userId) {

                    session.setAttribute(
                            "userName",
                            name.trim()
                    );

                    session.setAttribute(
                            "userRole",
                            role
                    );
                }
            }

            response.sendRedirect("admin-users");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to update user."
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
                    "Only administrators can edit users."
            );

            return false;
        }

        return true;
    }
}