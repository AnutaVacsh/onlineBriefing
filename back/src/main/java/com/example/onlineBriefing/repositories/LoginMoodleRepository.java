package com.example.onlineBriefing.repositories;

import com.example.onlineBriefing.models.LoginMoodle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LoginMoodleRepository extends JpaRepository<LoginMoodle,Integer> {
    LoginMoodle findByLogin(String login);
}
