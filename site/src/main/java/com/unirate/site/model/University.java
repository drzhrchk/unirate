package com.unirate.site.model;

import java.util.List;

import com.unirate.site.service.ProgramService;
import com.unirate.site.service.ReviewService;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "university")
public class University {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String city;
    private Double rating;
    private String speciality;
    private String description;
    private int foundationYear;
    private long studentsCount;
    private long teachersCount;
    private int facultiesCount;
    private int programsCount;
    private boolean hasDormitory;
    private String mapSource;

    public String getMapSource() {
        return mapSource;
    }

    public void setMapSource(String mapSource) {
        this.mapSource = mapSource;
    }

    @OneToMany(mappedBy = "university")
    private List<Program> programs;

    @OneToMany(mappedBy = "university")
    private List<Review> reviews;

    public List<Review> getReviews() {
        return reviews;
    }

    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }

    public long getTeachersCount() {
        return teachersCount;
    }

    public void setTeachersCount(long teachersCount) {
        this.teachersCount = teachersCount;
    }

    public boolean isHasDormitory() {
        return hasDormitory;
    }

    public void setHasDormitory(boolean hasDormitory) {
        this.hasDormitory = hasDormitory;
    }

    private String address;
    private String phone;
    private String email;
    private String website;

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getProgramsCount() {
        return programsCount;
    }

    public void setProgramsCount(int programsCount) {
        this.programsCount = programsCount;
    }

    public int getFacultiesCount() {
        return facultiesCount;
    }

    public void setFacultiesCount(int facultiesCount) {
        this.facultiesCount = facultiesCount;
    }

    public long getStudentsCount() {
        return studentsCount;
    }

    public void setStudentsCount(long studentsCount) {
        this.studentsCount = studentsCount;
    }

    public int getFoundationYear() {
        return foundationYear;
    }

    public void setFoundationYear(int foundationYear) {
        this.foundationYear = foundationYear;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSpeciality() {
        return speciality;
    }

    public void setSpeciality(String speciality) {
        this.speciality = speciality;
    }

    public Double getRating() {
        return rating;
    }

    public void setRating(Double rating) {
        this.rating = rating;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public University() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    @Override
    public String toString() {
        return "University [id=" + id + ", name=" + name + ", city=" + city + ", rating=" + rating + ", speciality="
                + speciality + ", description=" + description + ", foundationYear=" + foundationYear
                + ", studentsCount=" + studentsCount + ", teachersCount=" + teachersCount + ", facultiesCount="
                + facultiesCount + ", programsCount=" + programsCount + ", hasDormitory=" + hasDormitory + ", address="
                + address + ", phone=" + phone + ", email=" + email + ", website=" + website + "]";
    }

    public University(Long id, String name, String city, Double rating, String speciality, String description,
            int foundationYear, long studentsCount, long teachersCount, int facultiesCount, int programsCount,
            boolean hasDormitory, String address, String phone, String email, String website, String mapSource,
            ProgramService programService, ReviewService reviewService) {
        this.id = id;
        this.name = name;
        this.city = city;
        this.rating = rating;
        this.speciality = speciality;
        this.description = description;
        this.foundationYear = foundationYear;
        this.studentsCount = studentsCount;
        this.teachersCount = teachersCount;
        this.facultiesCount = facultiesCount;
        this.programsCount = programsCount;
        this.hasDormitory = hasDormitory;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.website = website;
        this.mapSource = mapSource;
        this.programs = programService.findByUniversityId(id);
        this.reviews = reviewService.findByUniversityId(id);
    }

    public List<Program> getPrograms() {
        return programs;
    }

    public void setPrograms(List<Program> programs) {
        this.programs = programs;
    }
}
