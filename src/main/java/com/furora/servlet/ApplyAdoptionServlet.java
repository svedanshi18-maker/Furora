package com.furora.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/apply-adoption")
public class ApplyAdoptionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String petId = request.getParameter("petId");

        if (petId == null || petId.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Pet ID is required."
            );

            return;
        }

        try {

            Integer.parseInt(petId);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid pet ID."
            );

            return;
        }

        request.getRequestDispatcher(
                "/apply-adoption.jsp"
        ).forward(request, response);
    }
}