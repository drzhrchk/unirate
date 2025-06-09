package com.unirate.site.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.unirate.site.model.University;
import com.unirate.site.repository.UniversityRepository;

@Service
public class UniversityService {

    private final UniversityRepository universityRepository;

    public UniversityService(UniversityRepository universityRepository) {
        this.universityRepository = universityRepository;
    }

    public List<University> findAll() {
        return universityRepository.findAll();
    }

    public University findUniversityById(Long id) {
        return universityRepository.findById(id).get();
    }

    public List<University> findByCity(String city) {
        return universityRepository.findByCity(city);
    }

    public List<University> findByProgramName(String programName) {
        return universityRepository.findByProgramName(programName);
    }

    public List<University> findByCityAndProgramName(String programName, String city) {
        return universityRepository.findByCityAndProgramName(programName, city);
    }

    public University create(University university) {
        return universityRepository.save(university);
    }

    public List<String> findDistinctCities() {
        return universityRepository.findDistinctCities();
    }

    public List<University> findAllOrderByAvgEducationRaiting() {
        return universityRepository.findAllOrderByAvgEducationRaiting();
    }

    public List<University> findAllOrderByAvgLifeRating() {
        return universityRepository.findAllOrderByAvgLifeRating();
    }

    public List<University> findAllOrderByAvgFoodRaiting() {
        return universityRepository.findAllOrderByAvgFoodRaiting();
    }

    public List<University> findAllOrderByAvgTeachersRaiting() {
        return universityRepository.findAllOrderByAvgTeachersRaiting();
    }
}
