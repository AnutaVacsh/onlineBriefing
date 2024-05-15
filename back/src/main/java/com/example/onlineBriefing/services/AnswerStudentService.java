package com.example.onlineBriefing.services;

import com.example.onlineBriefing.models.AnswerStudent;
import com.example.onlineBriefing.models.Plagiat;
import com.example.onlineBriefing.models.Question;
import com.example.onlineBriefing.repositories.AnswerStudentRepository;
import com.example.onlineBriefing.repositories.PlagiatRepository;
import com.example.onlineBriefing.repositories.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class AnswerStudentService {

    @Autowired
    private AnswerStudentRepository answerStudentRepository;
    @Autowired
    private QuestionRepository questionRepository;
    @Autowired
    private PlagiatRepository plagiatRepository;

    public List<AnswerStudent> addAnswer(List<AnswerStudent> answerStudents) {
        return answerStudentRepository.saveAll(answerStudents);
    }

    public List<AnswerStudent> checkAnswer(List<AnswerStudent> answerStudents) {
        Optional<Question> question;
        List<AnswerStudent> checkedAnswer = new ArrayList<>();
        for (AnswerStudent answerStudent : answerStudents) {
            question = questionRepository.findById(answerStudent.getQuestion());
            if (question.isPresent()) {
                if (Objects.equals(question.get().getTypeVerification(), "автоматически")) {
                    if(Objects.equals(question.get().getAnswer(), answerStudent.getText())){
                        answerStudent.setAccuracy_percent(new BigDecimal(100));
                       checkedAnswer.add(answerStudent);
                    }
                    else {
                        answerStudent.setAccuracy_percent(new BigDecimal(0));
                        checkedAnswer.add(answerStudent);
                    }
                }
            }
        }
        return answerStudentRepository.saveAll(checkedAnswer);
    }


    public String getAnswerDetails(Integer idQuestion, Integer idStudent) {
        AnswerStudent answerStudent = answerStudentRepository.findByQuestionAndIdStudent(idQuestion, idStudent);
        if (answerStudent == null) {
            throw new RuntimeException("Answer not found for question id: " + idQuestion + " and student id: " + idStudent);
        }

        String res = "";
        if(answerStudent.getText()!= null){
            res += "Ответ: "+answerStudent.getText()+".";
            if (answerStudent.getAccuracy_percent()!= null){
                res += " Балл: "+ answerStudent.getAccuracy_percent()+".";
            }
            if(getPlagiat(answerStudent)!=null){
                res += " Проверка на плагиат не пройдена.";
            }
        }else res = "Ответ на вопрос не был представлен";
        return res;
    }

    public Plagiat getPlagiat(AnswerStudent answerStudent){
        return plagiatRepository.findByAnswerStudent2(answerStudent.getId());
    }

    public Map<Integer, BigDecimal> updateAccuracyPercentAndGetAll(Integer id, BigDecimal accuracyPercent) {
        Optional<AnswerStudent> answerStudentOptional = answerStudentRepository.findById(id);
        if (answerStudentOptional.isPresent()) {
            AnswerStudent answerStudent = answerStudentOptional.get();
            answerStudent.setAccuracy_percent(accuracyPercent);
            answerStudentRepository.save(answerStudent);
        }
        return answerStudentRepository
                .findAll()
                .stream()
                .collect(Collectors.toMap(
                        AnswerStudent::getId,
                        AnswerStudent::getAccuracy_percent));
    }

    public Optional<AnswerStudent> updateAccuracyPercent(Integer id, BigDecimal accuracyPercent) {
        Optional<AnswerStudent> answerStudentOptional = answerStudentRepository.findById(id);
        if (answerStudentOptional.isPresent()) {
            AnswerStudent answerStudent = answerStudentOptional.get();
            answerStudent.setAccuracy_percent(accuracyPercent);
            answerStudentRepository.save(answerStudent);
            return Optional.of(answerStudent);
        }
        return Optional.empty();
    }

}
