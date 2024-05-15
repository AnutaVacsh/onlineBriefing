package com.example.onlineBriefing.repositories;

import com.example.onlineBriefing.models.Teacher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TeacherRepository extends JpaRepository<Teacher,Integer> {
    Teacher findByLogin(Integer login);
}
