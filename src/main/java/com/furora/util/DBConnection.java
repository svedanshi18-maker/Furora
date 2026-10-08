package com.furora.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String HOST =
            System.getenv("MYSQLHOST");

    private static final String PORT =
            System.getenv("MYSQLPORT");

    private static final String DATABASE =
            System.getenv("MYSQLDATABASE");

    private static final String USER =
            System.getenv("MYSQLUSER");

    private static final String PASSWORD =
            System.getenv("MYSQLPASSWORD");

    public static Connection getConnection() throws SQLException {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found.", e);
        }

        String url =
                "jdbc:mysql://" + HOST + ":" + PORT + "/" + DATABASE +
                        "?useSSL=false&serverTimezone=UTC";

        return DriverManager.getConnection(
                url,
                USER,
                PASSWORD
        );
    }
}