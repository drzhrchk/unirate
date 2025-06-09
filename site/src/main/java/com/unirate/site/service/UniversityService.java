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

    public University findByCity(String city) {
        return universityRepository.findByCity(city).get();
    }

    public University findByProgram(String programName) {
        return universityRepository.findByProgramName(programName).get();
    }

    public University findByCityAndProgramName(String programName, String city) {
        return universityRepository.findByCityAndProgramName(programName, city).get();
    }

    public University create(University university) {
        return universityRepository.save(university);
    }
}
