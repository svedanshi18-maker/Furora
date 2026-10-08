package com.furora.model;

public class Pet {

    private int id;
    private String name;
    private String petType;
    private int age;
    private String breed;
    private String gender;
    private String location;
    private String description;
    private String photo;

    public Pet(int id,
               String name,
               String petType,
               int age,
               String breed,
               String gender,
               String location,
               String description,
               String photo) {

        this.id = id;
        this.name = name;
        this.petType = petType;
        this.age = age;
        this.breed = breed;
        this.gender = gender;
        this.location = location;
        this.description = description;
        this.photo = photo;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getPetType() {
        return petType;
    }

    public int getAge() {
        return age;
    }

    public String getBreed() {
        return breed;
    }

    public String getGender() {
        return gender;
    }

    public String getLocation() {
        return location;
    }

    public String getDescription() {
        return description;
    }

    public String getPhoto() {
        return photo;
    }
}