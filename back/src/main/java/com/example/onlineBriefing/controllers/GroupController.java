package com.example.onlineBriefing.controllers;

import com.example.onlineBriefing.models.Profile;
import com.example.onlineBriefing.models.UniversityGroup;
import com.example.onlineBriefing.services.UniversityGroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@CrossOrigin
@RequestMapping("/briefing")
public class GroupController {

    @Autowired
    private UniversityGroupService universityGroupService;

    @GetMapping("/findGroup/{idProfile}/{yearBegin}/{number}")
    public ResponseEntity<Integer> findGroupId(
            @PathVariable Integer idProfile,
            @PathVariable Integer yearBegin,
            @PathVariable String number) {

        Optional<UniversityGroup> group = universityGroupService
                .findGroupByProfileYearAndNumber(idProfile, yearBegin, number);

        return group
                .map(universityGroup -> ResponseEntity.ok(universityGroup.getId()))
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @GetMapping("/getAllGroups")
    public ResponseEntity<List<UniversityGroup>> getAllGroups() {
        List<UniversityGroup> groups = universityGroupService.getAllGroups();
        return ResponseEntity.ok(groups);
    }

}
