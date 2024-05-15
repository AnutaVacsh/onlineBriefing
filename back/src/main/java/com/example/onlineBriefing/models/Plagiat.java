package com.example.onlineBriefing.models;

import jakarta.persistence.*;
import lombok.*;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Entity
@Table(name = "Plagiat")
public class Plagiat {

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "id_answer_student1", nullable = false)
    private Integer answerStudent1;

    @Column(name = "id_answer_student2", nullable = false)
    private Integer answerStudent2;

    public Plagiat(Integer answerStudent1, Integer answerStudent2) {
        this.answerStudent1 = answerStudent1;
        this.answerStudent2 = answerStudent2;
    }
}
