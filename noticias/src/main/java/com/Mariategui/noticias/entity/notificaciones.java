package com.Mariategui.noticias.entity;

import java.time.LocalDateTime;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PreUpdate;
import lombok.Data;

@Entity
@Data
public class notificaciones {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String titulo;
    private String descripcion;
    private String subdescripcion;
    private String status = "1";
    private String foto;
    private LocalDateTime created_at = LocalDateTime.now();
    private LocalDateTime updated_at = LocalDateTime.now();

    @PreUpdate
    private void preUpdate() {
        updated_at = LocalDateTime.now();
    }
}
