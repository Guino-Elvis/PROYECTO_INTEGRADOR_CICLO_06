package com.Mariategui.asistencia.service;

import java.util.List;
import java.util.Optional;

import com.Mariategui.asistencia.entity.Horario;

public interface HorarioService {

    public List<Horario> listar();

    public Horario guardar(Horario horario);

    public Horario actualizar(Horario horario);

    public Optional<Horario> listarPorId(Integer id);

    public void eliminarPorId(Integer id);
}
