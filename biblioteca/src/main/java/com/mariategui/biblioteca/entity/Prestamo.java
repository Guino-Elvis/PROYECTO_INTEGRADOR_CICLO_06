package com.mariategui.biblioteca.entity;

import java.time.LocalDateTime;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.mariategui.biblioteca.dto.AuthUser;

import jakarta.persistence.Id;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Transient;
import lombok.Data;

@Entity
@Data
public class Prestamo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private Integer userId;
    @Transient
    private AuthUser authUser;

    @JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
    private Libro libro;

    private String fecha_prestamo;
    private String fecha_devolucion;
    private String estado_prestamo;
    private LocalDateTime created_at = LocalDateTime.now();
    private LocalDateTime updated_at = LocalDateTime.now();

    @PreUpdate
    private void preUpdate() {
        updated_at = LocalDateTime.now();
    }
}
