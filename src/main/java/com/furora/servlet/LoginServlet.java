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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String sql = "SELECT id, name, role FROM users " +
                "WHERE email = ? AND password = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);
            statement.setString(2, password);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {

                    int userId = resultSet.getInt("id");
                    String name = resultSet.getString("name");
                    String role = resultSet.getString("role");

                    HttpSession session = request.getSession();

                    session.setAttribute("userId", userId);
                    session.setAttribute("userName", name);
                    session.setAttribute("userRole", role);

                    if ("ADMIN".equalsIgnoreCase(role)) {

                        response.sendRedirect("admin-dashboard.jsp");

                    } else if ("SHELTER".equalsIgnoreCase(role)) {

                        response.sendRedirect("shelter-dashboard.jsp");

                    } else if ("ADOPTER".equalsIgnoreCase(role)) {

                        response.sendRedirect("adopter-dashboard.jsp");

                    } else {

                        response.sendError(
                                HttpServletResponse.SC_FORBIDDEN,
                                "Invalid user role."
                        );
                    }

                } else {

                    response.getWriter().println(
                            "<h1>Login failed!</h1>"
                    );

                    response.getWriter().println(
                            "<p>Invalid email or password.</p>"
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "<h1>Something went wrong.</h1>"
            );
        }
    }
}