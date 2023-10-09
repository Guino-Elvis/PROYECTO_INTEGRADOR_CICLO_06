package com.Mariategui.alumno.service;

import java.util.List;
import java.util.Optional;

import com.Mariategui.alumno.entity.Alumno;

public interface AlumnoService {

    public List<Alumno> listar();

    public Alumno guardar(Alumno alumno);

    public Alumno actualizar(Alumno alumno);

    public Optional<Alumno> listarPorId(Integer id);

    public void eliminarPorId(Integer id);

}
