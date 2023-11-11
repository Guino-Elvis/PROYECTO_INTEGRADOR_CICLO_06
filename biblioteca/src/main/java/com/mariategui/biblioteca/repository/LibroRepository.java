package com.mariategui.biblioteca.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mariategui.biblioteca.entity.Libro;

public interface LibroRepository extends JpaRepository<Libro, Integer> {

    List<Libro> findByCategorialibId(Integer idCategoria);

}
