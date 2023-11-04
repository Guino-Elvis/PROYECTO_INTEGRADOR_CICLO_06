package com.mariategui.biblioteca.service;

import java.util.List;
import java.util.Optional;

import com.mariategui.biblioteca.entity.Libro;

public interface LibroService {
    public List<Libro> listar();

    public Libro guardar(Libro libro);

    public Libro actualizar(Libro libro);

    public Optional<Libro> listarPorId(Integer id);

    public void eliminarPorId(Integer id);
}
