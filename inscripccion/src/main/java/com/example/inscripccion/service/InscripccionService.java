package com.example.inscripccion.service;

import java.util.List;
import java.util.Optional;

import com.example.inscripccion.entity.Inscripccion;

public interface InscripccionService {
    public List<Inscripccion> listar();

    public Inscripccion guardar(Inscripccion inscripccion);

    public Inscripccion actualizar(Inscripccion inscripccion);

    public Optional<Inscripccion> listarPorId(Integer id);

    public void eliminarPorId(Integer id);
}
