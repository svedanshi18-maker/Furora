
package com.furora.servlet;

import com.furora.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role");

        if (name == null || email == null || password == null ||
                confirmPassword == null || role == null ||
                name.trim().isEmpty() || email.trim().isEmpty() ||
                password.isEmpty() || confirmPassword.isEmpty()) {

            response.sendRedirect("register.jsp?error=missing");
            return;
        }

        name = name.trim();
        email = email.trim();

        if (!"ADOPTER".equals(role) && !"SHELTER".equals(role)) {
            response.sendRedirect("register.jsp?error=role");
            return;
        }

        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=password");
            return;
        }

        if (password.length() < 8) {
            response.sendRedirect("register.jsp?error=weak");
            return;
        }

        String checkSql = "SELECT id FROM users WHERE email = ?";
        String insertSql =
                "INSERT INTO users (name, email, password, role) " +
                        "VALUES (?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection()) {

            try (PreparedStatement check =
                         connection.prepareStatement(checkSql)) {

                check.setString(1, email);

                try (ResultSet resultSet = check.executeQuery()) {
                    if (resultSet.next()) {
                        response.sendRedirect(
                                "register.jsp?error=exists");
                        return;
                    }
                }
            }

            try (PreparedStatement insert =
                         connection.prepareStatement(insertSql)) {

                insert.setString(1, name);
                insert.setString(2, email);
                insert.setString(3, password);
                insert.setString(4, role);

                insert.executeUpdate();
            }

            response.sendRedirect("login.jsp?registered=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=server");
        }
    }
}
