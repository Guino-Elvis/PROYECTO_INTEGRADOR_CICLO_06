package com.Mariategui.noticias.entity;

import java.time.LocalDateTime;

import com.Mariategui.noticias.dto.CategoriaBlog;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Transient;
import lombok.Data;

@Entity
@Data
public class Blog {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String titulo;

    @Column(columnDefinition = "TEXT")
    private String descripccion;

    private String foto;
    private Integer categoriaBlogId;
    private LocalDateTime created_at = LocalDateTime.now();
    private LocalDateTime updated_at = LocalDateTime.now();
    @Transient
    private CategoriaBlog categoriaBlog;

    @PreUpdate
    private void preUpdate() {
        updated_at = LocalDateTime.now();
    }

}
