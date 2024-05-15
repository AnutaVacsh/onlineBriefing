package com.example.onlineBriefing.models;

import jakarta.persistence.*;
import lombok.*;

import java.time.Duration;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Entity
@Table(name = "Briefing")
public class Briefing {

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_subject", nullable = false)
    private Integer idSubject;

    @Column(name = "number", nullable = false)
    private Integer number;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "duration")
    private String duration;

    @Column(name = "status", nullable = false)
    private String status;//ENUM:   OPEN, CLOSE

    public Briefing(Integer idSubject, Integer number, String title, String duration, String status) {
        this.idSubject = idSubject;
        this.number = number;
        this.title = title;
        this.duration = duration;
        this.status = status;
    }
}
