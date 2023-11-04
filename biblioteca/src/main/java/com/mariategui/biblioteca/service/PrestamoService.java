package com.mariategui.biblioteca.service;

import java.util.List;
import java.util.Optional;

import com.mariategui.biblioteca.entity.Prestamo;

public interface PrestamoService {
    public List<Prestamo> listar();

    public Prestamo guardar(Prestamo prestamo);

    public Prestamo actualizar(Prestamo prestamo);

    public Optional<Prestamo> listarPorId(Integer id);

    public void eliminarPorId(Integer id);
}
