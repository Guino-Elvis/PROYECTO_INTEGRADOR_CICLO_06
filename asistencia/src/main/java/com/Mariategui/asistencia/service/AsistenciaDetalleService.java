package com.Mariategui.asistencia.service;

import java.util.List;
import java.util.Optional;

import com.Mariategui.asistencia.entity.AsistenciaAlumnoDetalle;

public interface AsistenciaDetalleService {
    public List<AsistenciaAlumnoDetalle> listar();

    public AsistenciaAlumnoDetalle guardar(AsistenciaAlumnoDetalle asistenciaAlumnoDetalle);

    public AsistenciaAlumnoDetalle actualizar(AsistenciaAlumnoDetalle asistenciaAlumnoDetalle);

    public Optional<AsistenciaAlumnoDetalle> listarPorId(Integer id);

    public void eliminarPorId(Integer id);
}
