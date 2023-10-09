package com.Mariategui.curso.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Mariategui.curso.entity.Curso;

public interface CursoRepository extends JpaRepository<Curso, Integer> {

}
