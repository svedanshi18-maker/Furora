package com.furora.dao;

import com.furora.model.Pet;
import com.furora.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PetDAO {

    public List<Pet> getAllPets() {

        List<Pet> pets = new ArrayList<>();

        String sql =
                "SELECT id, name, pet_type, age, breed, gender, " +
                        "location, description, photo " +
                        "FROM pets " +
                        "WHERE status = 'APPROVED'";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                Pet pet = new Pet(
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("pet_type"),
                        resultSet.getInt("age"),
                        resultSet.getString("breed"),
                        resultSet.getString("gender"),
                        resultSet.getString("location"),
                        resultSet.getString("description"),
                        resultSet.getString("photo")
                );

                pets.add(pet);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return pets;
    }


    public List<Pet> searchPets(String petType,
                                String breed,
                                String location) {

        List<Pet> pets = new ArrayList<>();

        String sql =
                "SELECT id, name, pet_type, age, breed, gender, " +
                        "location, description, photo " +
                        "FROM pets " +
                        "WHERE status = 'APPROVED' " +
                        "AND pet_type LIKE ? " +
                        "AND breed LIKE ? " +
                        "AND location LIKE ?";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(
                    1,
                    "%" + petType + "%"
            );

            statement.setString(
                    2,
                    "%" + breed + "%"
            );

            statement.setString(
                    3,
                    "%" + location + "%"
            );

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    Pet pet = new Pet(
                            resultSet.getInt("id"),
                            resultSet.getString("name"),
                            resultSet.getString("pet_type"),
                            resultSet.getInt("age"),
                            resultSet.getString("breed"),
                            resultSet.getString("gender"),
                            resultSet.getString("location"),
                            resultSet.getString("description"),
                            resultSet.getString("photo")
                    );

                    pets.add(pet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return pets;
    }


    public Pet getPetById(int id) {

        String sql =
                "SELECT id, name, pet_type, age, breed, gender, " +
                        "location, description, photo " +
                        "FROM pets " +
                        "WHERE id = ? AND status = 'APPROVED'";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, id);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {

                    return new Pet(
                            resultSet.getInt("id"),
                            resultSet.getString("name"),
                            resultSet.getString("pet_type"),
                            resultSet.getInt("age"),
                            resultSet.getString("breed"),
                            resultSet.getString("gender"),
                            resultSet.getString("location"),
                            resultSet.getString("description"),
                            resultSet.getString("photo")
                    );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}