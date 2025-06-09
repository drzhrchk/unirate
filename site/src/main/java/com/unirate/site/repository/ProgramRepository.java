package com.unirate.site.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.unirate.site.model.Program;

@Repository
public interface ProgramRepository extends JpaRepository<Program, Long> {
    @Query(value = "SELECT * FROM program WHERE university_id = :universityId", nativeQuery = true)
    Optional<List<Program>> findByUniversityId(Long universityId);

    @Query(value = "SELECT DISTINCT name FROM program", nativeQuery = true)
    List<String> findDistinctProgramNames();
}
