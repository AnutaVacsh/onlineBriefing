package com.example.onlineBriefing.services;

import com.example.onlineBriefing.models.News;
import com.example.onlineBriefing.models.Student;
import com.example.onlineBriefing.models.Subject;
import com.example.onlineBriefing.repositories.SubjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class SubjectService {

    @Autowired
    private SubjectRepository subjectRepository;

    public List<Subject> getAllSubjectsByIdProfile(Integer idProfile) {
        return subjectRepository.findAllByIdProfile(idProfile);
    }
    public List<Subject> getAllSubjectsByIdTeacher(Integer idTeacher) {
        return subjectRepository.findAllByIdTeacher(idTeacher);
    }

    public Optional<Subject> findSubjectById(Integer id) {
        return subjectRepository.findById(id);
    }

}
