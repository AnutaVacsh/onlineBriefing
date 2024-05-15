package com.example.onlineBriefing.controllers;

import com.example.onlineBriefing.exceptions.BriefingNotFoundException;
import com.example.onlineBriefing.models.AnswerStudent;
import com.example.onlineBriefing.models.Briefing;
import com.example.onlineBriefing.models.Subject;
import com.example.onlineBriefing.services.AnswerStudentService;
import com.example.onlineBriefing.services.BriefingService;
import com.example.onlineBriefing.services.PlagiatService;
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
public class BriefingController {

    @Autowired
    private BriefingService briefingService;
    @Autowired
    private AnswerStudentService answerStudentService;
    @Autowired
    private PlagiatService plagiatService;


    @GetMapping(value = "/getBriefings/{id_subject}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> getBriefings(@PathVariable Integer id_subject) {
        return ResponseEntity.status(HttpStatus.OK)
                .body(briefingService.getAllBriefingsByIdSubject(id_subject));
    }

    @PostMapping("/addAnswer")
    public ResponseEntity<?> addAnswerStudent(@RequestBody List<AnswerStudent> answerStudents) {
        List<AnswerStudent> addedAnswerStudents = answerStudentService.addAnswer(answerStudents);//Добавляем в БД
        System.out.println(answerStudentService.checkAnswer(addedAnswerStudents)); //Ответы на вопросы с автоматической проверкой сразу проверяются
        plagiatService.plagiatCheckAll(answerStudents);
        return ResponseEntity.ok(addedAnswerStudents);
    }

    @PutMapping("/editStatus/{id}")
    public Briefing editStatus(@RequestBody String status, @PathVariable Integer id){
        return briefingService.findBriefingById(id)
                .map(br -> {
                    br.setStatus(status);
                    return briefingService.addBriefing(br);
                }).orElseThrow(() -> new BriefingNotFoundException(id));
    }

    @PutMapping("/editStatusInBriefings/{id}")
    public ResponseEntity<Briefing> editStatusInBriefing(@RequestBody String status, @PathVariable Integer id) {
        List<Briefing> briefings = briefingService.findAllBriefings();
        Briefing briefingToUpdate = briefings.stream()
                .filter(briefing -> briefing.getId().equals(id))
                .findFirst()
                .orElseThrow(() -> new BriefingNotFoundException(id));

        briefingToUpdate.setStatus(status);
        briefingService.addBriefing(briefingToUpdate);
        return ResponseEntity.ok(briefingToUpdate);
    }

    @PostMapping("/addBriefing")
    public ResponseEntity<Integer> addBriefing(@RequestBody Briefing briefing) {
        Briefing savedBriefing = briefingService.addBriefing(briefing);
        return ResponseEntity.ok(savedBriefing.getId());
    }

    @GetMapping(value = "/getBriefing/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Optional<Briefing>> getBriefing(@PathVariable Integer id){
        return ResponseEntity.status(HttpStatus.OK)
                .body(briefingService.findBriefingById(id));
    }

}
