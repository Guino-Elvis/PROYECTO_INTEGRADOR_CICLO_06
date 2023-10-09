package com.Mariategui.asistencia.service;

import java.util.List;
import java.util.Optional;

import com.Mariategui.asistencia.entity.AsistenciaAlumno;

public interface AsistenciaAlumnoService {

    public List<AsistenciaAlumno> listar();

    public AsistenciaAlumno guardar(AsistenciaAlumno asistenciaAlumno);

    public AsistenciaAlumno actualizar(AsistenciaAlumno asistenciaAlumno);

    public Optional<AsistenciaAlumno> listarPorId(Integer id);

    public void eliminarPorId(Integer id);
}
