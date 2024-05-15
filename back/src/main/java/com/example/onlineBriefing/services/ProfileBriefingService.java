package com.example.onlineBriefing.services;

import com.example.onlineBriefing.models.ProfileBriefing;
import com.example.onlineBriefing.models.UniversityGroup;
import com.example.onlineBriefing.repositories.ProfileBriefingRepository;
import com.example.onlineBriefing.repositories.UniversityGroupRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ProfileBriefingService {

    @Autowired
    private final ProfileBriefingRepository profileBriefingRepository;
    @Autowired
    private final UniversityGroupRepository universityGroupRepository;

    @Autowired
    public ProfileBriefingService(ProfileBriefingRepository profileBriefingRepository, UniversityGroupRepository universityGroupRepository) {
        this.profileBriefingRepository = profileBriefingRepository;
        this.universityGroupRepository = universityGroupRepository;
    }

    public List<UniversityGroup> findGroupsByBriefingId(Integer briefingId) {
        List<ProfileBriefing> profileBriefings = profileBriefingRepository.findAllByBriefing(briefingId);
        List<Integer> profileIds = profileBriefings
                .stream()
                .map(ProfileBriefing::getProfile)
                .collect(Collectors.toList());
        return universityGroupRepository.findByIdProfileIn(profileIds);
    }
}
