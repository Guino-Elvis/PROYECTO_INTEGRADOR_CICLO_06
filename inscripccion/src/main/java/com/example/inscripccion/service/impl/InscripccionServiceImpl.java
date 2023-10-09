package com.example.inscripccion.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.inscripccion.dto.Alumno;
import com.example.inscripccion.dto.Curso;
import com.example.inscripccion.entity.Inscripccion;
import com.example.inscripccion.entity.InscripccionDetalle;
import com.example.inscripccion.feign.AlumnoFeign;
import com.example.inscripccion.feign.CursoFeign;
import com.example.inscripccion.repository.InscripccionRepository;
import com.example.inscripccion.service.InscripccionService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class InscripccionServiceImpl implements InscripccionService {

    // inyectamos con autowired
    @Autowired
    private InscripccionRepository inscripccionRepository;
    @Autowired
    private AlumnoFeign alumnoFeign;

    @Autowired
    private CursoFeign cursoFeign;

    @Override
    public List<Inscripccion> listar() {
        return inscripccionRepository.findAll();
    }

    @Override
    public Inscripccion guardar(Inscripccion inscripccion) {
        return inscripccionRepository.save(inscripccion);
    }

    @Override
    public Inscripccion actualizar(Inscripccion inscripccion) {
        return inscripccionRepository.save(inscripccion);
    }

    @Override
    public Optional<Inscripccion> listarPorId(Integer id) {
        // union de tablas
        Inscripccion inscripccion = inscripccionRepository.findById(id).get();

        Alumno alumno = alumnoFeign.listById(inscripccion.getAlumnoId()).getBody();
        List<InscripccionDetalle> inscripccionDetalles = inscripccion.getDetalle().stream().map(inscripccionDetalle -> {
            System.out.println(inscripccionDetalle.toString());
            System.out.println("Antes de la peticion");
            Curso curso = cursoFeign.listById(inscripccionDetalle.getCursoId()).getBody();
            System.out.println("Despues de la peticion");
            System.out.println(curso.toString());
            System.out.println(curso.getNombre());
            inscripccionDetalle.setCurso(curso);
            return inscripccionDetalle;
        }).collect(Collectors.toList());
        inscripccion.setDetalle(inscripccionDetalles);

        inscripccion.setAlumno(alumno);
        return Optional.of(inscripccion);
    }

    @Override
    public void eliminarPorId(Integer id) {
        inscripccionRepository.deleteById(id);
    }
}
