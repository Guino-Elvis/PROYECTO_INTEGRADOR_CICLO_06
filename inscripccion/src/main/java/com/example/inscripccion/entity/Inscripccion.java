package com.example.inscripccion.entity;

import java.time.LocalDateTime;
import java.util.List;

import com.example.inscripccion.dto.AuthUser;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Inscripccion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String serie;
    private String numero;
    private String descripcion;

    private Integer userId;
    @Transient
    private AuthUser authUser;

    // private Integer alumnoId;
    @JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
    @OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "inscripccion_id")
    private List<InscripccionDetalle> detalle;
    // @Transient
    // private Alumno alumno;

    private LocalDateTime created_at = LocalDateTime.now();
    private LocalDateTime updated_at = LocalDateTime.now();

    @PreUpdate
    private void preUpdate() {
        updated_at = LocalDateTime.now();
    }
}
