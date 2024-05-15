package com.example.onlineBriefing.services;

import com.example.onlineBriefing.models.News;
import com.example.onlineBriefing.repositories.AnswerStudentRepository;
import com.example.onlineBriefing.repositories.NewsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NewsService {
    @Autowired
    private NewsRepository newsRepository;

    public List<News> getAllNewsByIdProfile(Integer idProfile) {
        return newsRepository.findAllByIdProfile(idProfile);
    }

    public List<News> getNewsByTeacherId(Integer idTeacher) {
        return newsRepository.findByIdTeacherOrderByDateStartDesc(idTeacher);
    }

    public News addNews(News news) {
        return newsRepository.save(news);
    }


}
