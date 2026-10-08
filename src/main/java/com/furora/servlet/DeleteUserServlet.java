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

@WebServlet("/delete-user")
public class DeleteUserServlet extends HttpServlet {

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

            userId =
                    Integer.parseInt(userIdParameter);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid user ID."
            );

            return;
        }

        HttpSession session =
                request.getSession(false);

        int loggedInUserId =
                (Integer) session.getAttribute("userId");

        // Prevent the admin from deleting their own account.
        if (userId == loggedInUserId) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "You cannot delete your own administrator account."
            );

            return;
        }

        String sql =
                "DELETE FROM users WHERE id = ?";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            int rowsDeleted =
                    statement.executeUpdate();

            if (rowsDeleted == 0) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "User not found."
                );

                return;
            }

            response.sendRedirect("admin-users");

        } catch (Exception e) {

            e.printStackTrace();

            /*
             * A user may be referenced by pets,
             * applications, or messages.
             * The database foreign-key constraints
             * can therefore prevent deletion.
             */
            response.sendError(
                    HttpServletResponse.SC_CONFLICT,
                    "This user cannot be deleted because they are associated with existing Furora records."
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
                    "Only administrators can delete users."
            );

            return false;
        }

        return true;
    }
}