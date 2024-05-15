package com.example.onlineBriefing.services;

import com.example.onlineBriefing.models.Briefing;
import com.example.onlineBriefing.models.LoginMoodle;
import com.example.onlineBriefing.models.Student;
import com.example.onlineBriefing.repositories.BriefingRepository;
import com.example.onlineBriefing.repositories.LoginMoodleRepository;
import com.example.onlineBriefing.repositories.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.relational.core.sql.In;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class StudentService {

    @Autowired
    private StudentRepository studentRepository;
    @Autowired
    private LoginMoodleRepository loginMoodleRepository;

    public Student getStudentByLogin(LoginMoodle login){
        Integer loginId = loginMoodleRepository.findByLogin(login.getLogin()).getId();
        if(loginId!=null){
            return studentRepository.findByLogin(loginId) ;
        }
        return null;
    }

    public Optional<Student> findStudentById(Integer id) {
        return studentRepository.findById(id);
    }

}
