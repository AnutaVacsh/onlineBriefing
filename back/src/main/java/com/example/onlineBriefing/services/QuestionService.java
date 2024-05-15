package com.example.onlineBriefing.services;

import com.example.onlineBriefing.models.Question;
import com.example.onlineBriefing.repositories.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class QuestionService {

    @Autowired
    private QuestionRepository questionRepository;
    public List<Question> getQuestionsByIdBriefing(Integer id_briefing){
        return questionRepository.findAllByBriefing(id_briefing) ;
    }

    public List<Question> addQuestions(List<Question> questions) {
        return questionRepository.saveAll(questions);
    }
}
