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
@Table(name = "Question")
public class Question {

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "id_briefing", nullable = false)
    private Integer briefing;

    @Column(name = "text", nullable = false)
    private String text;

    @Column(name = "type_verification")
    private String typeVerification;

    @Column(name = "answer")
    private String answer;

    @Builder(toBuilder = true)
    public Question(Integer briefing, String text, String typeVerification, String answer) {
        this.briefing = briefing;
        this.text = text;
        this.typeVerification = typeVerification;
        if (typeVerification.equals("automatically")) {
            this.answer = null;
        } else {
            this.answer = answer;
        }
    }

}
