package com.example.onlineBriefing.repositories;

import com.example.onlineBriefing.models.AnswerStudent;
import com.example.onlineBriefing.models.Plagiat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PlagiatRepository extends JpaRepository<Plagiat,Integer> {
    Plagiat findByAnswerStudent2(Integer answerStudent2);
}
