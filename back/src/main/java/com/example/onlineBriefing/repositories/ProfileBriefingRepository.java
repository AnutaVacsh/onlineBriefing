package com.example.onlineBriefing.repositories;

import com.example.onlineBriefing.models.ProfileBriefing;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProfileBriefingRepository extends JpaRepository<ProfileBriefing,Integer> {
    ProfileBriefing findByBriefing(Integer briefing);

    List<ProfileBriefing> findAllByBriefing(Integer briefingId);
}
