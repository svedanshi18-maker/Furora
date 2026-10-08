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

@WebServlet("/system-settings")
public class SystemSettingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) {
            return;
        }

        List<Setting> settings = new ArrayList<>();

        String sql =
                "SELECT id, setting_name, setting_value " +
                        "FROM system_settings " +
                        "ORDER BY id ASC";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                Setting setting = new Setting(
                        resultSet.getInt("id"),
                        resultSet.getString("setting_name"),
                        resultSet.getString("setting_value")
                );

                settings.add(setting);
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load system settings."
            );

            return;
        }

        request.setAttribute(
                "settings",
                settings
        );

        request.getRequestDispatcher(
                "/system-settings.jsp"
        ).forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) {
            return;
        }

        String settingIdParameter =
                request.getParameter("settingId");

        String settingValue =
                request.getParameter("settingValue");

        if (settingIdParameter == null ||
                settingIdParameter.trim().isEmpty() ||
                settingValue == null) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Setting ID and value are required."
            );

            return;
        }

        int settingId;

        try {

            settingId =
                    Integer.parseInt(settingIdParameter);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid setting ID."
            );

            return;
        }

        String sql =
                "UPDATE system_settings " +
                        "SET setting_value = ? " +
                        "WHERE id = ?";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(
                    1,
                    settingValue.trim()
            );

            statement.setInt(
                    2,
                    settingId
            );

            int rowsUpdated =
                    statement.executeUpdate();

            if (rowsUpdated == 0) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "System setting not found."
                );

                return;
            }

            response.sendRedirect(
                    "system-settings"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to update system setting."
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
                    "Only administrators can manage system settings."
            );

            return false;
        }

        return true;
    }


    public static class Setting {

        private int id;
        private String name;
        private String value;

        public Setting(int id,
                       String name,
                       String value) {

            this.id = id;
            this.name = name;
            this.value = value;
        }

        public int getId() {
            return id;
        }

        public String getName() {
            return name;
        }

        public String getValue() {
            return value;
        }
    }
}