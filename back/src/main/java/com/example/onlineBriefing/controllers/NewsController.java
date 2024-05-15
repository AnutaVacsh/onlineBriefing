package com.example.onlineBriefing.controllers;

import com.example.onlineBriefing.models.News;
import com.example.onlineBriefing.services.NewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/briefing")
public class NewsController {

    @Autowired
    private NewsService newsService;

    @GetMapping(value = "/getNews/{id_profile}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> getNews(@PathVariable Integer id_profile) {
        return ResponseEntity.status(HttpStatus.OK)
                .body(newsService.getAllNewsByIdProfile(id_profile));
    }

    @GetMapping(value = "/newsByTeacher/{idTeacher}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<News>> getNewsByTeacherId(@PathVariable Integer idTeacher) {
        List<News> newsList = newsService.getNewsByTeacherId(idTeacher);
        if (newsList.isEmpty()) {
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.ok(newsList);
        }
    }

    @PostMapping("/addNew")
    public ResponseEntity<News> addNews(@RequestBody News news) {
        News savedNews = newsService.addNews(news);
        return ResponseEntity.ok(savedNews);
    }

}
