package com.example.onlineBriefing.repositories;

import com.example.onlineBriefing.models.News;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NewsRepository extends JpaRepository<News,Integer> {

    List<News> findAllByIdProfile(Integer idProfile);
    List<News> findByIdTeacherOrderByDateStartDesc(Integer idTeacher);

}
