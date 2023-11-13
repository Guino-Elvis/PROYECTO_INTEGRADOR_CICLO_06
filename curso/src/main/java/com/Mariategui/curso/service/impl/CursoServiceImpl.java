package com.Mariategui.curso.service.impl;

import org.springframework.stereotype.Service;

import com.Mariategui.curso.dto.Docente;
import com.Mariategui.curso.entity.Curso;
import com.Mariategui.curso.entity.Video;
import com.Mariategui.curso.feign.DocenteFeign;
import com.Mariategui.curso.repository.CursoRepository;
import com.Mariategui.curso.service.CursoService;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

@Service
public class CursoServiceImpl implements CursoService {

    @Autowired
    private VideoServiceImpl videoService;

    @Autowired
    private CursoRepository cursoRepository;

    @Autowired
    private DocenteFeign docenteFeign;

    @Override
    public List<Curso> listar() {
        return cursoRepository.findAll();
    }

    @Override
    public Curso guardar(Curso curso) {
        return cursoRepository.save(curso);
    }

    @Override
    public Curso actualizar(Curso curso) {
        return cursoRepository.save(curso);
    }

    @Override
    public Optional<Curso> listarPorId(Integer id) {
        // Obtención del curso por su ID
        Curso curso = cursoRepository.findById(id).get();
        if (curso != null) {
            System.out.println("Antes de la petición");
            // Obtención del docente asociado al curso
            Optional<Video> videoOptional = videoService.listarPorId(curso.getVideo().getId());
            Docente docente = docenteFeign.listById(curso.getDocenteId()).getBody();
            videoOptional.ifPresent(video -> {
                System.out.println("Después de la petición");
                System.out.println(video.toString());
                System.out.println(video.getTitulo());
                System.out.println(video.getId());
                curso.setVideo(video);
            });
            System.out.println("Después de la petición");
            System.out.println(docente.toString());
            System.out.println(docente.getNombre());
            curso.setDocente(docente);
        }
        return Optional.ofNullable(curso);
    }

    @Override
    public void eliminarPorId(Integer id) {
        cursoRepository.deleteById(id);
    }
}
