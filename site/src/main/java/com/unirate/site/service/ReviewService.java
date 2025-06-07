package com.unirate.unirate.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.unirate.unirate.model.Review;
import com.unirate.unirate.repository.ReviewRepository;
@Service
public class ReviewService {
    private final ReviewRepository reviewRepository;

    public ReviewService(ReviewRepository reviewRepository) {
        this.reviewRepository = reviewRepository;
    }


    public List<Review> findByUniversityId(Long universityId){
        return reviewRepository.findByUniversityId(universityId);
    }

    public Review create(Review review){
        return reviewRepository.save(review);
    }
}

