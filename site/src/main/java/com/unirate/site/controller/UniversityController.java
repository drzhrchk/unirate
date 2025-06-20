package com.unirate.site.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unirate.site.model.Review;
import com.unirate.site.model.University;
import com.unirate.site.service.ProgramService;
import com.unirate.site.service.ReviewService;
import com.unirate.site.service.UniversityService;

@Controller
public class UniversityController {

    private final UniversityService universityService;
    private final ProgramService programService;
    private final ReviewService reviewService;

    public UniversityController(UniversityService universityService, ProgramService programService,
            ReviewService reviewService) {
        this.universityService = universityService;
        this.programService = programService;
        this.reviewService = reviewService;
    }

    @GetMapping("/")
    public String showHomePage(Model model) {
        model.addAttribute("universities", universityService.findAllOrderByRating());
        model.addAttribute("program", universityService.findAll());
        model.addAttribute("programNames", programService.findDisttinctProgramNames());
        model.addAttribute("cityNames", universityService.findDistinctCities());
        return "index"; // templates/index.html
    }

    @GetMapping("/universities/{pageNumber}")
    public String showUniversityPage(@PathVariable Long pageNumber, Model model) {
        University university = universityService.findUniversityById(pageNumber);
        university.setReviews(reviewService.findByUniversityId(pageNumber));
        university.setPrograms(programService.findByUniversityId(pageNumber));
        model.addAttribute("university", university);

        return "university";
    }

    @GetMapping("/api")
    @ResponseBody
    public List<University> findAllUniversities() {
        return universityService.findAll();
    }

    @PostMapping("/api/create")
    @ResponseBody
    public University createUniversity(@RequestBody University university) {
        return universityService.create(university);
    }

    @PostMapping("/universities/{id}/reviews")
    public String createReview(
            @RequestParam Double rating,
            @RequestParam String text,
            @RequestParam String author,
            @RequestParam Double educationRating,
            @RequestParam Double teachersRating,
            @RequestParam Double foodRating,
            @RequestParam Double lifeRating,
            @PathVariable Long id) {
        reviewService.create(new Review(universityService.findUniversityById(id), author, rating, text, educationRating,
                teachersRating, foodRating, lifeRating));
        return "redirect:/universities/" + id;
    }

    @GetMapping("/ratings")
    public String getRaitings(Model model) {
        model.addAttribute("rating1", universityService.findAllOrderByAvgEducationRaiting());
        model.addAttribute("rating2", universityService.findAllOrderByAvgFoodRaiting());
        model.addAttribute("rating3", universityService.findAllOrderByAvgLifeRating());
        model.addAttribute("rating4", universityService.findAllOrderByAvgTeachersRaiting());

        return "ratings";
    }

    @GetMapping("/error")
    public String exceptionHandler() {
        return "errors/404";
    }
}
