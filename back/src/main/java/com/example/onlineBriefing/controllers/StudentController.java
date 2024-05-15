package com.example.onlineBriefing.controllers;

import com.example.onlineBriefing.models.AnswerStudent;
import com.example.onlineBriefing.models.Plagiat;
import com.example.onlineBriefing.models.Student;
import com.example.onlineBriefing.services.AnswerStudentService;
import com.example.onlineBriefing.services.BriefingService;
import com.example.onlineBriefing.services.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@CrossOrigin
@RequestMapping("/briefing")
public class StudentController {

    @Autowired
    private StudentService studentService;
    @Autowired
    private BriefingService briefingService;
    @Autowired
    private AnswerStudentService answerStudentService;

    @GetMapping(value = "/getStudent/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Optional<Student>> getStudent(@PathVariable Integer id){
        return ResponseEntity.status(HttpStatus.OK)
                .body(studentService.findStudentById(id));
    }
    //Средний балл по предмету
    @GetMapping("/averageGrade/{idStudent}/{subject}")
    public ResponseEntity<Double> getAverageGradeBySubject(@PathVariable Integer idStudent, @PathVariable Integer subject) {
        double averageGrade = briefingService.calculateAverageGradeBySubject(idStudent, subject);
        return ResponseEntity.ok(averageGrade);
    }

    //Получить инфо о ответе студента
    @PostMapping("/answerDetails/{idStudent}")
    public ResponseEntity<?> getAnswerDetails(@RequestBody Integer idQuestion, @PathVariable Integer idStudent) {
        String res = answerStudentService.getAnswerDetails(idQuestion, idStudent);
        return ResponseEntity.ok(res);
    }
    @PostMapping("/getPlagiat")
    public ResponseEntity<?> getPlagiat(@RequestBody AnswerStudent answerStudent) {
        Plagiat plagiat = answerStudentService.getPlagiat(answerStudent);
        if (plagiat==null){
            ResponseEntity.ok("Плагиата нет");
        }
        return ResponseEntity.ok(plagiat.getAnswerStudent1());
    }
    //Получить рейтинг студента
    @GetMapping("/getRating/{idStudent}/{subject}")
    public ResponseEntity<?> getRating(@PathVariable Integer idStudent, @PathVariable Integer subject){
        return ResponseEntity.ok(briefingService.getTopStudent(idStudent, subject));
    }
    //Получить список баллов по всем летучкам предмета
    @GetMapping("/getScores/{idStudent}/{subject}")
    public List<Double> getScores(@PathVariable Integer idStudent, @PathVariable Integer subject){
        return briefingService. getAllScores(idStudent, subject);
    }

}
