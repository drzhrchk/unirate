package com.unirate.site.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.unirate.site.model.Review;
import com.unirate.site.repository.ReviewRepository;

@Service
public class ReviewService {
    private final ReviewRepository reviewRepository;

    public ReviewService(ReviewRepository reviewRepository) {
        this.reviewRepository = reviewRepository;
    }

    public List<Review> findByUniversityId(Long universityId) {
        return reviewRepository.findByUniversityId(universityId);
    }

    public Review create(Review review) {
        return reviewRepository.save(review);
    }
}
