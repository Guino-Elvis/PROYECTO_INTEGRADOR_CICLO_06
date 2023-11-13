package com.Mariategui.asistencia.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import com.Mariategui.asistencia.dto.AuthUser;

import lombok.Data;

@Entity
@Data
public class AsistenciaAlumnoDetalle {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    // private Integer alumnoId;

    // @Transient
    // private Alumno alumno;
    private Integer userId;
    @Transient
    private AuthUser authUser;
    private Integer status = 1;

    private LocalDateTime created_at = LocalDateTime.now();
    private LocalDateTime updated_at = LocalDateTime.now();

    @PreUpdate
    private void preUpdate() {
        updated_at = LocalDateTime.now();
    }
}
