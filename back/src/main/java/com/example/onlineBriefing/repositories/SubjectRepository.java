package com.example.onlineBriefing.repositories;

import com.example.onlineBriefing.models.News;
import com.example.onlineBriefing.models.Student;
import com.example.onlineBriefing.models.Subject;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface SubjectRepository extends JpaRepository<Subject,Integer> {

    List<Subject> findAllByIdProfile(Integer idProfile);
    List<Subject> findAllByIdTeacher(Integer idTeacher);
    Optional<Subject> findById(Integer id);

}
