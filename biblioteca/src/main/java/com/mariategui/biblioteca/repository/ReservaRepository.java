package com.mariategui.biblioteca.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mariategui.biblioteca.entity.Reserva;

public interface ReservaRepository extends JpaRepository<Reserva, Integer> {

}
