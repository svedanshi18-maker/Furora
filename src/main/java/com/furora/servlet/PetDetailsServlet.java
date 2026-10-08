package com.furora.servlet;

import com.furora.dao.PetDAO;
import com.furora.model.Pet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/pet-details")
public class PetDetailsServlet extends HttpServlet {

    private final PetDAO petDAO = new PetDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String idParameter = request.getParameter("id");

        if (idParameter == null) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Pet ID is missing."
            );
            return;
        }

        int id;

        try {
            id = Integer.parseInt(idParameter);
        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid pet ID."
            );
            return;
        }

        Pet pet = petDAO.getPetById(id);

        if (pet == null) {
            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Pet not found."
            );
            return;
        }

        request.setAttribute("pet", pet);

        request.getRequestDispatcher("/pet-details.jsp")
                .forward(request, response);
    }
}