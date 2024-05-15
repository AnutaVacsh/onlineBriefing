package com.example.onlineBriefing.controllers;

import com.example.onlineBriefing.services.AnswerStudentService;
import com.example.onlineBriefing.services.BriefingService;
import com.example.onlineBriefing.services.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin
@RequestMapping("/briefing")
public class TeacherController {
    @Autowired
    private BriefingService briefingService;
    @Autowired
    private AnswerStudentService answerStudentService;
    @Autowired
    private TeacherService teacherService;
    @GetMapping("/getTop/{subject}/{group}")
    public ResponseEntity<?> getTopStudents(@PathVariable Integer subject,@PathVariable Integer group){
        return ResponseEntity.ok(briefingService.getTopStudents(subject, group));
    }
    //Средний балл по вопросам летучки группы
    @GetMapping("/getQuestionCheck/{briefing}/{group}")
    public ResponseEntity<?> getQuestionCheck(@PathVariable Integer briefing,@PathVariable Integer group){
        return ResponseEntity.ok(briefingService.getQuestionAvgGrade(briefing,group));
    }

    //Средний балл по летучкам предмета среди всех групп

    @GetMapping("/getQuestionAvgGrade/{subjectId}")
    public ResponseEntity<?> getQuestionAvgGrade(@PathVariable Integer subjectId){
        return ResponseEntity.ok(briefingService.getQuestionAvgGrade(subjectId));
    }
    //Непроверенные ответы на вопросы препода
    @GetMapping("/getQuestionNoCheck/{teacherId}")
    public ResponseEntity<?> getQuestionNoCheck(@PathVariable Integer teacherId){
        return ResponseEntity.ok(teacherService.getAnswerNoMark(teacherId));
    }
    //Непроверенные списанные ответы на вопросы препода
    @GetMapping("/getQuestionNoCheckAndPlagiat/{teacherId}")
    public ResponseEntity<?> getQuestionNoCheckAndPlagiat(@PathVariable Integer teacherId){
        return ResponseEntity.ok(teacherService.getAnswerNoMarkAndPlagiat(teacherId));
    }
}
