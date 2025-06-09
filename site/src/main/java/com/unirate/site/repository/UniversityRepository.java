package com.unirate.site.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.unirate.site.model.University;

@Repository
public interface UniversityRepository extends JpaRepository<University, Long> {
    @Query(value = "SELECT * FROM university WHERE name = :name", nativeQuery = true)
    Optional<University> findByName(String name);

    @Query(value = "SELECT * FROM university WHERE ORDER BY rating", nativeQuery = true)
    List<University> find();

    @Query(value = "SELECT * FROM university WHERE id = :id", nativeQuery = true)
    Optional<University> findById(Long id);

    @Query(value = "SELECT * FROM university WHERE city = :city", nativeQuery = true)
    Optional<University> findByCity(String name);

    @Query(value = "SELECT * FROM university WHERE id = (SELECT id FROM program WHERE name = :programName)", nativeQuery = true)
    Optional<University> findByProgramName(String programName);

    @Query(value = " SELECT u.* FROM university u JOIN program on u.id = program.university_id  WHERE city = :city AND program.name = :programName", nativeQuery = true)
    Optional<University> findByCityAndProgramName(String programName, String city);

    @Query(value = "SELECT DISTINCT city FROM university", nativeQuery = true)
    List<String> findDistinctCities();
}
