package com.Mariategui.alumno.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Mariategui.alumno.entity.Alumno;
import com.Mariategui.alumno.repository.AlumnoRepository;
import com.Mariategui.alumno.service.AlumnoService;

import java.util.List;
import java.util.Optional;

@Service
public class AlumnoServiceImpl implements AlumnoService {
    @Autowired
    private AlumnoRepository alumnoRepository;

    @Override
    public List<Alumno> listar() {
        return alumnoRepository.findAll();
    }

    @Override
    public Alumno guardar(Alumno alumno) {
        return alumnoRepository.save(alumno);
    }

    @Override
    public Alumno actualizar(Alumno alumno) {
        return alumnoRepository.save(alumno);
    }

    @Override
    public Optional<Alumno> listarPorId(Integer id) {
        return alumnoRepository.findById(id);
    }

    @Override
    public void eliminarPorId(Integer id) {
        alumnoRepository.deleteById(id);
    }

}
