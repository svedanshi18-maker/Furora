package com.furora.servlet;

import com.furora.dao.PetDAO;
import com.furora.model.Pet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/all-pets")
public class PetsServlet extends HttpServlet {

    private final PetDAO petDAO = new PetDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String petType = request.getParameter("petType");
        String breed = request.getParameter("breed");
        String location = request.getParameter("location");

        if (petType == null) {
            petType = "";
        }

        if (breed == null) {
            breed = "";
        }

        if (location == null) {
            location = "";
        }

        List<Pet> pets;

        if (petType.trim().isEmpty() &&
                breed.trim().isEmpty() &&
                location.trim().isEmpty()) {

            pets = petDAO.getAllPets();

        } else {

            pets = petDAO.searchPets(
                    petType.trim(),
                    breed.trim(),
                    location.trim()
            );
        }

        request.setAttribute(
                "pets",
                pets
        );

        request.setAttribute(
                "petType",
                petType
        );

        request.setAttribute(
                "breed",
                breed
        );

        request.setAttribute(
                "location",
                location
        );

        request.getRequestDispatcher(
                "/pets.jsp"
        ).forward(request, response);
    }
}