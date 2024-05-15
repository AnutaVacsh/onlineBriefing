package com.example.onlineBriefing.services;

import com.example.onlineBriefing.models.*;
import com.example.onlineBriefing.repositories.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class TeacherService {

    @Autowired
    private TeacherRepository teacherRepository;
    @Autowired
    private BriefingRepository briefingRepository;
    @Autowired
    private AnswerStudentRepository answerStudentRepository;
    @Autowired
    private QuestionRepository questionRepository;
    @Autowired
    private UniversityGroupRepository universityGroupRepository;
    @Autowired
    private StudentRepository studentRepository;
    @Autowired
    private SubjectRepository subjectRepository;
    @Autowired
    private ProfileRepository profileRepository;
    @Autowired
    private ProfileBriefingRepository profileBriefingRepository;
    @Autowired
    private PlagiatRepository plagiatRepository;
    @Autowired
    private LoginMoodleRepository loginMoodleRepository;

    public Teacher getTeacherByLogin(LoginMoodle login) {
        Integer loginId = loginMoodleRepository.findByLogin(login.getLogin()).getId();
        if (loginId != null) {
            return teacherRepository.findByLogin(loginId);
        }
        return null;
    }

    //Получить непроверенные летучки учителя
    public List<AnswerStudent> getAnswerNoMark(Integer teacherId) {
        List<Subject> subjects = subjectRepository.findAllByIdTeacher(teacherId);
        List<Integer> groups = new ArrayList<>();
        for (Subject subject : subjects) {
            groups.add(subject.getIdProfile());
        }
        List<AnswerStudent> res = new ArrayList<>();
        Student student;
        for (AnswerStudent answerStudent : answerStudentRepository.findAll()) {
            if (answerStudent.getAccuracy_percent() == null) {
                student = studentRepository
                        .findById(answerStudent.getIdStudent())
                        .get();
                if (groups.contains(student.getIdGroup())) {
                    res.add(answerStudent);
                }
            }
        }
        return res;
    }

    public List<Plagiat> getAnswerNoMarkAndPlagiat(Integer teacherId) {
        List<AnswerStudent> answerStudents = getAnswerNoMark(teacherId);
        List<Plagiat> res = new ArrayList<>();
        for (AnswerStudent answerStudent : answerStudents) {
            Plagiat plagiat = plagiatRepository.findByAnswerStudent2(answerStudent.getId());
            if (plagiat != null) {
                res.add(plagiat);
            }
        }
        return res;
    }
}
