package com.mariategui.biblioteca.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mariategui.biblioteca.entity.Prestamo;

public interface PrestamosRepository extends JpaRepository<Prestamo, Integer> {

}
