package com.example.onlineBriefing.controllers;

import com.example.onlineBriefing.models.LoginMoodle;
import com.example.onlineBriefing.models.Student;
import com.example.onlineBriefing.models.Teacher;
import com.example.onlineBriefing.services.LoginMoodleService;
import com.example.onlineBriefing.services.StudentService;
import com.example.onlineBriefing.services.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Objects;

@RestController
@CrossOrigin
@RequestMapping("/briefing")
public class AuthenticationController {
    @Autowired
    private LoginMoodleService loginMoodleService;
    @Autowired
    private StudentService studentService;
    @Autowired
    private TeacherService teacherService;
    @PostMapping("/login/{status}") //Здесь выводится LoginMoodle
    public ResponseEntity<?> logClient(@PathVariable String status, @RequestBody String login ){
        LoginMoodle loginMoodle = loginMoodleService.auth(new LoginMoodle(login, status));
        if(loginMoodle == null){
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(loginMoodle);
    }
    @PostMapping("/auth")//Здесь мы отправляем LoginMoodle
    public ResponseEntity<?> getStudentByLogin(@RequestBody LoginMoodle loginMoodle){
        if (Objects.equals(loginMoodle.getStatus(), "teacher")){
            Teacher teacher = teacherService.getTeacherByLogin(loginMoodle);
            if(teacher == null){
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(teacher) ;
        }
        else if (Objects.equals(loginMoodle.getStatus(), "student")) {
            Student student = studentService.getStudentByLogin(loginMoodle);
            if(student == null){
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(student) ;
        }
        return ResponseEntity.notFound().build();
    }

}
