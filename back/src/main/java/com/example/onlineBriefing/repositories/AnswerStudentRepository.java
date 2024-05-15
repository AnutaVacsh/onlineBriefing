package com.example.onlineBriefing.repositories;

import com.example.onlineBriefing.models.AnswerStudent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AnswerStudentRepository extends JpaRepository<AnswerStudent,Integer> {
    List<AnswerStudent> findAllByIdStudent(Integer idStudent);
    AnswerStudent findByQuestion(Integer question);
    AnswerStudent findByQuestionAndIdStudent(Integer question, Integer idStudent);

    List<AnswerStudent> findAllByQuestion(Integer id);
}
