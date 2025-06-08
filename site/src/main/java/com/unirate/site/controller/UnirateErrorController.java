package com.unirate.site.controller;

import java.time.LocalDateTime;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;

import com.unirate.site.model.ErrorResponse;

@Controller
public class UnirateErrorController implements ErrorController {

    @RequestMapping("/error")
    public ResponseEntity<ErrorResponse> handleError(HttpServletRequest request) {
        Integer status = (Integer) request.getAttribute("javax.servlet.error.status_code");
        Exception exception = (Exception) request.getAttribute("javax.servlet.error.exception");

        ErrorResponse error = new ErrorResponse(
                status != null ? status.toString() : "500",
                exception != null ? exception.getMessage() : "Unexpected error occurred",
                LocalDateTime.now());

        return new ResponseEntity<>(
                error,
                status != null ? HttpStatus.valueOf(status) : HttpStatus.INTERNAL_SERVER_ERROR);
    }
}