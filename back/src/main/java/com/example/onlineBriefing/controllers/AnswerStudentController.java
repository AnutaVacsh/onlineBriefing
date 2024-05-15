package com.example.onlineBriefing.controllers;

import com.example.onlineBriefing.models.AnswerStudent;
import com.example.onlineBriefing.services.AnswerStudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.Map;

@RestController
@CrossOrigin
@RequestMapping("/briefing")
public class AnswerStudentController {

    @Autowired
    private AnswerStudentService answerStudentService;

    @PutMapping("/updateMarkAndGetMap/{id}")
    public ResponseEntity<Map<Integer, BigDecimal>> updateAccuracyPercentAndGetAll(
            @PathVariable Integer id,
            @RequestBody BigDecimal accuracyPercent) {
        Map<Integer, BigDecimal> accuracyMap = answerStudentService.updateAccuracyPercentAndGetAll(id, accuracyPercent);
        if (accuracyMap.isEmpty()) {
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.ok(accuracyMap);
        }
    }

    @PutMapping("/updateMark/{id}")
    public ResponseEntity<AnswerStudent> updateAccuracyPercent(
            @PathVariable Integer id,
            @RequestBody BigDecimal accuracyPercent) {
        return answerStudentService.updateAccuracyPercent(id, accuracyPercent)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

}
