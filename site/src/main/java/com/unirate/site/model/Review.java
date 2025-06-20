package com.unirate.site.model;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "reviews")
public class Review {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String author;
    private Double rating;
    private String text;
    private Double educationRating;
    private Double teachersRating;
    private Double foodRating;
    private Double lifeRating;
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;
    @ManyToOne
    @JoinColumn(name = "university_id")
    private University university;

    public Double getEducationRating() {
        return educationRating;
    }

    public void setEducationRating(Double educationRating) {
        this.educationRating = educationRating;
    }

    public Double getTeachersRating() {
        return teachersRating;
    }

    public void setTeachersRating(Double teachersRating) {
        this.teachersRating = teachersRating;
    }

    public Double getFoodRating() {
        return foodRating;
    }

    public void setFoodRating(Double foodRating) {
        this.foodRating = foodRating;
    }

    public Double getLifeRating() {
        return lifeRating;
    }

    public void setLifeRating(Double lifeRating) {
        this.lifeRating = lifeRating;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime created_at) {
        this.createdAt = created_at;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Double getRating() {
        return rating;
    }

    public void setRating(Double rating) {
        this.rating = rating;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Review() {
    }

    public Review(University university, String author, Double rating, String text) {
        this.author = author;
        this.rating = rating;
        this.text = text;
        this.university = university;
        this.createdAt = LocalDateTime.now();
    }

    public Review(String author, Double rating, String text) {
        this.author = author;
        this.rating = rating;
        this.text = text;
        this.createdAt = LocalDateTime.now();
    }

    public Review(University university, String author, Double rating, String text, Double educationRating,
            Double teachersRating,
            Double foodRating, Double lifeRating) {
        this.university = university;
        this.author = author;
        this.rating = rating;
        this.text = text;
        this.educationRating = educationRating;
        this.teachersRating = teachersRating;
        this.foodRating = foodRating;
        this.lifeRating = lifeRating;
        this.createdAt = LocalDateTime.now();
    }

    public University getUniversity() {
        return university;
    }

    public void setUniversity(University university) {
        this.university = university;
    }

}
