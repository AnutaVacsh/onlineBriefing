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
@Table(name = "profilebriefing")
public class ProfileBriefing {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id; // Уникальный идентификатор для ProfileBriefing

    @Column(name = "id_profile", nullable = false)
    private Integer profile;

    @Column(name = "id_briefing", nullable = false)
    private Integer briefing;

}
