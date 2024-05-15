package com.example.onlineBriefing.controllers;

import com.example.onlineBriefing.models.Student;
import com.example.onlineBriefing.models.Subject;
import com.example.onlineBriefing.services.NewsService;
import com.example.onlineBriefing.services.SubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@CrossOrigin
@RequestMapping("/briefing")
public class SubjectController {

    @Autowired
    private SubjectService subjectService;

    @GetMapping(value = "/getSubjects/{id_profile}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> getSubjects(@PathVariable Integer id_profile) {
        return ResponseEntity.status(HttpStatus.OK)
                .body(subjectService.getAllSubjectsByIdProfile(id_profile));
    }

    @GetMapping(value = "/getSubjectsByTeacher/{id_teacher}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> getSubjectsByTeacher(@PathVariable Integer id_teacher) {
        return ResponseEntity.status(HttpStatus.OK)
                .body(subjectService.getAllSubjectsByIdTeacher(id_teacher));
    }

    @GetMapping(value = "/getSubject/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Optional<Subject>> getSubject(@PathVariable Integer id){
        return ResponseEntity.status(HttpStatus.OK)
                .body(subjectService.findSubjectById(id));
    }

}
