package com.mariategui.biblioteca.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mariategui.biblioteca.entity.Libro;

public interface LibroRepository extends JpaRepository<Libro, Integer> {

}
