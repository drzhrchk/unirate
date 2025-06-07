package com.unirate.unirate.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.unirate.unirate.model.University;
import com.unirate.unirate.repository.UniversityRepository;

@Service
public class UniversityService {
    
    private final UniversityRepository universityRepository;

    public UniversityService(UniversityRepository universityRepository) {
        this.universityRepository = universityRepository;
    }

    public List<University> findAll() {
        return universityRepository.findAll();
    }

    public University findUniversityById(Long id){
        return universityRepository.findById(id).get();
    }

    public University findByCity(String city){
        return universityRepository.findByCity(city).get();
    }

    public University findByProgram(String programName){
        return universityRepository.findByProgramName(programName).get();
    }

    public University findByCItyAndProgramName(String programName, String city){
        return universityRepository.findByCItyAndProgramName(programName, city).get();
    }

    public University create(University university) {
        return universityRepository.save(university);
    }
}
