package com.example.onlineBriefing.repositories;

import com.example.onlineBriefing.models.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.relational.core.sql.In;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

@Repository
public interface StudentRepository extends JpaRepository<Student,Integer> {
    Student findByLogin(Integer idLogin);
    Optional<Student> findById(Integer id);

    List<Student> findAllByIdGroup(Integer idGroup);
}
