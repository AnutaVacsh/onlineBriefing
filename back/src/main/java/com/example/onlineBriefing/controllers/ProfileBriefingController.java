package com.example.onlineBriefing.controllers;

import com.example.onlineBriefing.models.UniversityGroup;
import com.example.onlineBriefing.services.ProfileBriefingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/briefing")
public class ProfileBriefingController {
    @Autowired
    private final ProfileBriefingService profileBriefingService;

    @Autowired
    public ProfileBriefingController(ProfileBriefingService profileBriefingService) {
        this.profileBriefingService = profileBriefingService;
    }

    @GetMapping("/groupsByBriefing/{idBriefing}")
    public ResponseEntity<List<UniversityGroup>> getGroupsByBriefingId(@PathVariable Integer idBriefing) {
        List<UniversityGroup> groups = profileBriefingService.findGroupsByBriefingId(idBriefing);
        if (groups.isEmpty()) {
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.ok(groups);
        }
    }
}
