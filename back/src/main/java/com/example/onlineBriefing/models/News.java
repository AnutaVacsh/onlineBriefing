package com.example.onlineBriefing.models;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Entity
@Table(name = "News")
public class News {

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "date_start", nullable = false)
    private LocalDateTime dateStart;

    @Column(name = "text", nullable = false)
    private String text;

    @Column(name = "id_teacher", nullable = false)
    private Integer idTeacher;

    @Column(name = "id_profile", nullable = false)
    private Integer idProfile;
}
