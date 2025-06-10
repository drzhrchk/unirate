package com.unirate.site.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "program")
public class Program {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long facultyId;
    private String name;
    private String degree;
    private String description;
    private Double tuitionFee;
    private Double minScore;
    private Double avgScore;

    @ManyToOne
    @JoinColumn(name = "university_id")
    private University university;

    public Program() {
    }

    public Program(Long id, Long universityId, Long facultyId, String name, String degree, String description,
            Double tuitionFee, University university) {

        this.id = id;
        this.facultyId = facultyId;
        this.name = name;
        this.degree = degree;
        this.description = description;
        this.tuitionFee = tuitionFee;
        this.university = university;
    }

    public Program(Long facultyId, String name, String degree, String description, Double tuitionFee, Double minScore,
            Double avgScore, University university) {
        this.facultyId = facultyId;
        this.name = name;
        this.degree = degree;
        this.description = description;
        this.tuitionFee = tuitionFee;
        this.minScore = minScore;
        this.avgScore = avgScore;
        this.university = university;
    }

    public Double getMinScore() {
        return minScore;
    }

    public void setMinScore(Double minScore) {
        this.minScore = minScore;
    }

    public Double getAvgScore() {
        return avgScore;
    }

    public void setAvgScore(Double avgScore) {
        this.avgScore = avgScore;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getFacultyId() {
        return facultyId;
    }

    public void setFacultyId(Long facultyId) {
        this.facultyId = facultyId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDegree() {
        return degree;
    }

    public void setDegree(String degree) {
        this.degree = degree;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getTuitionFee() {
        return tuitionFee;
    }

    public void setTuitionFee(Double tuitionFee) {
        this.tuitionFee = tuitionFee;
    }

    public University getUniversity() {
        return university;
    }

    public void setUniversity(University university) {
        this.university = university;
    }

}
