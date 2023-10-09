package com.Mariategui.alumno.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Mariategui.alumno.entity.Alumno;

public interface AlumnoRepository extends JpaRepository<Alumno, Integer> {

}
