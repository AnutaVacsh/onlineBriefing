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
@Table(name = "loginmoodle")
public class LoginMoodle {
    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "login", nullable = false)
    private String login;

    @Column(name = "status", nullable = false)
    private String status;//ENUM: STUDENT, TEACHER

    public LoginMoodle(String login, String status) {
        this.login = login;
        this.status = status;
    }
}
