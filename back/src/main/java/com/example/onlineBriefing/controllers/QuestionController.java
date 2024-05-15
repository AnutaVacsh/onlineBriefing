package com.example.onlineBriefing.controllers;

import com.example.onlineBriefing.models.Question;
import com.example.onlineBriefing.services.NewsService;
import com.example.onlineBriefing.services.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/briefing")
public class QuestionController {
    @Autowired
    private QuestionService questionService;
    @GetMapping("/questions/{id_briefing}")
    public ResponseEntity<?> getQuestions(@PathVariable Integer id_briefing){
        if(questionService.getQuestionsByIdBriefing(id_briefing).isEmpty()){
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(questionService.getQuestionsByIdBriefing(id_briefing)) ;
    }

    @PostMapping("/addAllQuestionForBriefing")
    public ResponseEntity<?> addQuestionsByBriefing(@RequestBody List<Question> questions) {
        List<Question> savedQuestions = questionService.addQuestions(questions);
        return ResponseEntity.ok(savedQuestions);
    }
}
