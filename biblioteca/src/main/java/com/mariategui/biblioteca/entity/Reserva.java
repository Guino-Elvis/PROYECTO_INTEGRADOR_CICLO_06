package com.mariategui.biblioteca.entity;

import java.sql.Date;
import java.time.LocalDateTime;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.mariategui.biblioteca.dto.AuthUser;

import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Transient;
import lombok.Data;

@Entity
@Data
public class Reserva {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private Integer userId;

    @Transient
    private AuthUser authUser;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "libro_id")
    @JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
    private Libro libro;

    private Date fecha_reserva;
    private String estado_reserva;
    private LocalDateTime created_at = LocalDateTime.now();
    private LocalDateTime updated_at = LocalDateTime.now();

    @PreUpdate
    private void preUpdate() {
        updated_at = LocalDateTime.now();
    }

    // Custom method to set userId with a message if authUser is null
    public void setUserIdWithMessage(String message) {
        if (authUser == null) {
            userId = null;
        } else {
            userId = authUser.getId();
        }
    }
}
