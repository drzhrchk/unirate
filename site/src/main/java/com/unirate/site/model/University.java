package com.unirate.site.model;

import java.util.List;

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
    private String speciality;
    private String description;
    private int foundationYear;
    private long studentsCount;
    private long teachersCount;
    private int facultiesCount;
    private int programsCount;
    private boolean hasDormitory;
    private String mapSource;
    private Double avgEducationRating;
    private Double avgTeachersRating;
    private Double avgFoodRating;
    private Double avgLifeRating;
    private Double rating;
    private String image;

    public University(String name, String city, String speciality, String description,
            int foundationYear, long studentsCount, long teachersCount, int facultiesCount, int programsCount,
            boolean hasDormitory, String mapSource, Double educationRating, Double teachersRating, Double foodRating,
            Double rating, Double lifeRating, List<Program> programs, List<Review> reviews, String address,
            String phone,
            String email, String website) {
        this.name = name;
        this.city = city;
        this.speciality = speciality;
        this.description = description;
        this.foundationYear = foundationYear;
        this.studentsCount = studentsCount;
        this.teachersCount = teachersCount;
        this.facultiesCount = facultiesCount;
        this.programsCount = programsCount;
        this.hasDormitory = hasDormitory;
        this.mapSource = mapSource;
        this.avgEducationRating = educationRating;
        this.avgTeachersRating = teachersRating;
        this.avgFoodRating = foodRating;
        this.avgLifeRating = lifeRating;
        this.rating = rating;
        this.programs = programs;
        this.reviews = reviews;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.website = website;
    }

    public Double getAvgEducationRating() {
        return avgEducationRating;
    }

    public void setAvgEducationRating(Double avgEducationRating) {
        this.avgEducationRating = avgEducationRating;
    }

    public Double getAvgTeachersRating() {
        return avgTeachersRating;
    }

    public void setAvgTeachersRating(Double avgTeachersRating) {
        this.avgTeachersRating = avgTeachersRating;
    }

    public Double getAvgFoodRating() {
        return avgFoodRating;
    }

    public void setAvgFoodRating(Double avgFoodRating) {
        this.avgFoodRating = avgFoodRating;
    }

    public Double getAvgLifeRating() {
        return avgLifeRating;
    }

    public void setAvgLifeRating(Double avgLifeRating) {
        this.avgLifeRating = avgLifeRating;
    }

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
        return "University [id=" + id + ", name=" + name + ", city=" + city + ", speciality="
                + speciality + ", description=" + description + ", foundationYear=" + foundationYear
                + ", studentsCount=" + studentsCount + ", teachersCount=" + teachersCount + ", facultiesCount="
                + facultiesCount + ", programsCount=" + programsCount + ", hasDormitory=" + hasDormitory + ", address="
                + address + ", phone=" + phone + ", email=" + email + ", website=" + website + "]";
    }

    public List<Program> getPrograms() {
        return programs;
    }

    public void setPrograms(List<Program> programs) {
        this.programs = programs;
    }

    public Double getRating() {
        return rating;
    }

    public void setRating(Double Rating) {
        rating = Rating;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public University(String name, String city, String speciality, String description, int foundationYear,
            long studentsCount, long teachersCount, int facultiesCount, int programsCount, boolean hasDormitory,
            String mapSource, Double avgEducationRating, Double avgTeachersRating, Double avgFoodRating,
            Double avgLifeRating, Double rating, String image, List<Program> programs, List<Review> reviews,
            String address, String phone, String email, String website) {
        this.name = name;
        this.city = city;
        this.speciality = speciality;
        this.description = description;
        this.foundationYear = foundationYear;
        this.studentsCount = studentsCount;
        this.teachersCount = teachersCount;
        this.facultiesCount = facultiesCount;
        this.programsCount = programsCount;
        this.hasDormitory = hasDormitory;
        this.mapSource = mapSource;
        this.avgEducationRating = avgEducationRating;
        this.avgTeachersRating = avgTeachersRating;
        this.avgFoodRating = avgFoodRating;
        this.avgLifeRating = avgLifeRating;
        this.rating = rating;
        this.image = image;
        this.programs = programs;
        this.reviews = reviews;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.website = website;
    }

}
