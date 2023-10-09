package com.Mariategui.asistencia.entity;

import jakarta.persistence.*;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import java.time.LocalDateTime;

import com.Mariategui.asistencia.dto.Alumno;

import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class AsistenciaAlumnoDetalle {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private Integer alumnoId;

    @Transient
    private Alumno alumno;

    private Integer status = 1;
    private LocalDateTime created_at = LocalDateTime.now();
    private LocalDateTime updated_at = LocalDateTime.now();
}
