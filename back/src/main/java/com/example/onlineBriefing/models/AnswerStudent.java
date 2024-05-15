package com.example.onlineBriefing.models;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Entity
@Table(name = "Answer_Student")
public class AnswerStudent {

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "id_student", nullable = false)
    private Integer idStudent;

    @Column(name = "id_question", nullable = false)
    private Integer question;

    @Column(name = "text")
    private String text;

    @Column(name = "accuracy_percent", precision = 5, scale = 2, columnDefinition = "NUMERIC(5,2) CHECK (accuracy_percent >= 0 AND accuracy_percent <= 100)")
    private BigDecimal accuracy_percent;

    public AnswerStudent(Integer idStudent, Integer question, String text) {
        this.idStudent = idStudent;
        this.question = question;
        this.text = text;
    }
}
