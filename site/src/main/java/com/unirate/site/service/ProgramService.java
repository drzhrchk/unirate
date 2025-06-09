package com.unirate.site.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.unirate.site.model.Program;
import com.unirate.site.repository.ProgramRepository;

@Service
public class ProgramService {
    private final ProgramRepository programRepository;

    public ProgramService(ProgramRepository programRepository) {
        this.programRepository = programRepository;
    }

    public List<Program> findByUniversityId(Long universityId) {
        return programRepository.findByUniversityId(universityId).get();
    }

    public List<String> findDisttinctProgramNames() {
        return programRepository.findDistinctProgramNames();
    }
}
