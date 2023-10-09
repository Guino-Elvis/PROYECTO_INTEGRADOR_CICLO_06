package com.Mariategui.asistencia.entity;

import java.time.LocalDateTime;
import java.util.List;

import com.Mariategui.asistencia.dto.Curso;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import jakarta.persistence.Entity;
import lombok.Data;

@Entity
@Data
public class AsistenciaAlumno {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private Integer cursoId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "horario_id")

    @JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
    private Horario horario;

    @Transient
    private Curso curso;

    private LocalDateTime created_at = LocalDateTime.now();
    private LocalDateTime updated_at = LocalDateTime.now();
    @JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
    @OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "asistencia_alumno_id")
    private List<AsistenciaAlumnoDetalle> detalle;
}
