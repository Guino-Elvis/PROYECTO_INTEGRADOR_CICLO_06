package com.Mariategui.asistencia.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Mariategui.asistencia.dto.Alumno;
import com.Mariategui.asistencia.dto.Curso;
import com.Mariategui.asistencia.entity.AsistenciaAlumno;
import com.Mariategui.asistencia.entity.AsistenciaAlumnoDetalle;
import com.Mariategui.asistencia.entity.Horario;
import com.Mariategui.asistencia.feign.AlumnoFeign;
import com.Mariategui.asistencia.feign.CursoFeign;
import com.Mariategui.asistencia.repository.AsistenciaAlumnoRepository;
import com.Mariategui.asistencia.service.AsistenciaAlumnoService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class AsistenciaAlumnoServiceImpl implements AsistenciaAlumnoService {
    // inyectamos con autowired

    @Autowired
    private AlumnoFeign alumnoFeign;

    @Autowired
    private CursoFeign cursoFeign;

    @Autowired
    private HorarioServiceImpl horarioService; // Cambio en la inyección de dependencia

    @Autowired
    private AsistenciaAlumnoRepository asistenciaAlumnoRepository;

    @Override
    public List<AsistenciaAlumno> listar() {
        return asistenciaAlumnoRepository.findAll();
    }

    @Override
    public AsistenciaAlumno guardar(AsistenciaAlumno asistenciaAlumno) {
        return asistenciaAlumnoRepository.save(asistenciaAlumno);
    }

    @Override
    public AsistenciaAlumno actualizar(AsistenciaAlumno asistenciaAlumno) {
        return asistenciaAlumnoRepository.save(asistenciaAlumno);
    }

    @Override
    public Optional<AsistenciaAlumno> listarPorId(Integer id) {
        // Cambio en la asignación de variable
        AsistenciaAlumno asistenciaAlumno = asistenciaAlumnoRepository.findById(id).orElse(null);
        // Curso curso = cursoFeign.listById(asistenciaAlumno.getCursoId()).getBody();
        if (asistenciaAlumno != null) {
            // Cambio en la obtención del horario
            Horario horario = horarioService.listarPorId(asistenciaAlumno.getHorario().getId()).orElse(null);
            // Cambio en la obtención del curso
            Curso curso = cursoFeign.listById(asistenciaAlumno.getCursoId()).getBody();
            if (horario != null) {
                List<AsistenciaAlumnoDetalle> asistenciaAlumnoDetalles = asistenciaAlumno.getDetalle().stream()
                        .map(asistenciaAlumnoDetalle -> {
                            System.out.println(asistenciaAlumnoDetalle.toString());
                            System.out.println("Antes de la petición");
                            // Cambio en la obtención del alumno
                            Alumno alumno = alumnoFeign.listById(asistenciaAlumnoDetalle.getAlumnoId()).getBody();
                            System.out.println("Después de la petición");
                            System.out.println(alumno.toString());
                            System.out.println(alumno.getNombre());
                            asistenciaAlumnoDetalle.setAlumno(alumno);

                            return asistenciaAlumnoDetalle;
                        }).collect(Collectors.toList());
                asistenciaAlumno.setDetalle(asistenciaAlumnoDetalles);

                asistenciaAlumno.setHorario(horario);
                asistenciaAlumno.setCurso(curso);
            }
        }
        return Optional.ofNullable(asistenciaAlumno);
    }

    @Override
    public void eliminarPorId(Integer id) {
        asistenciaAlumnoRepository.deleteById(id);
    }
}
