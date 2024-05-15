package com.example.onlineBriefing.services;

import com.example.onlineBriefing.models.LoginMoodle;
import com.example.onlineBriefing.repositories.AnswerStudentRepository;
import com.example.onlineBriefing.repositories.LoginMoodleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class LoginMoodleService {

    @Autowired
    private LoginMoodleRepository loginMoodleRepository;
    public LoginMoodle auth(LoginMoodle loginMoodle){
        return loginMoodleRepository.findByLogin(loginMoodle.getLogin());
    }
}
