package com.example.onlineBriefing.services;

import com.example.onlineBriefing.models.Profile;
import com.example.onlineBriefing.models.UniversityGroup;
import com.example.onlineBriefing.repositories.UniversityGroupRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UniversityGroupService {

    @Autowired
    private UniversityGroupRepository universityGroupRepository;

    public Optional<UniversityGroup> findGroupByProfileYearAndNumber(Integer idProfile, Integer yearBegin, String number) {
        return universityGroupRepository.findByIdProfileAndYearBeginAndNumber(idProfile, yearBegin, number);
    }

    public List<UniversityGroup> getAllGroups() {
        return universityGroupRepository.findAll();
    }
}
