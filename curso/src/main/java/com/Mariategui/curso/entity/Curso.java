package com.Mariategui.curso.entity;

import java.time.LocalDateTime;

import com.Mariategui.curso.dto.Docente;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Transient;
import lombok.Data;

@Entity
@Data
public class Curso {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String nombre;
    private Double costo;
    private String foto;
    private Integer docenteId;

    private LocalDateTime created_at = LocalDateTime.now();
    private LocalDateTime updated_at = LocalDateTime.now();
    @Transient
    private Docente docente;

    public Curso() {
        this.costo = (double) 0;
    }
}
