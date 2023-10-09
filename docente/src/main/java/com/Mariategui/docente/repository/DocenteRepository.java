package com.Mariategui.docente.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Mariategui.docente.entity.Docente;

public interface DocenteRepository extends JpaRepository<Docente, Integer> {

}
