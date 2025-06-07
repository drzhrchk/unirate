package com.unirate.site.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.unirate.site.model.Review;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {
    @Query(value = "SELECT * FROM reviews WHERE university_id = :universityId ORDER BY created_at", nativeQuery = true)
    List<Review> findByUniversityId(Long universityId);
}
