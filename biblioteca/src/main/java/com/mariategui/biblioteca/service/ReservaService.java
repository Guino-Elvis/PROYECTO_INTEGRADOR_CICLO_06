package com.mariategui.biblioteca.service;

import java.util.List;
import java.util.Optional;

import com.mariategui.biblioteca.entity.Reserva;

public interface ReservaService {
    public List<Reserva> listar();

    public Reserva guardar(Reserva reserva);

    public Reserva actualizar(Reserva reserva);

    public Optional<Reserva> listarPorId(Integer id);

    public void eliminarPorId(Integer id);
}
