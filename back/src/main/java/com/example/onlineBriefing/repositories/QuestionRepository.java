package com.example.onlineBriefing.repositories;

import com.example.onlineBriefing.models.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuestionRepository extends JpaRepository<Question,Integer> {
    List <Question> findAllByBriefing(Integer id_briefing);

}
