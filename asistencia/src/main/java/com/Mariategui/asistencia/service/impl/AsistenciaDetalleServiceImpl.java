package com.Mariategui.asistencia.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Mariategui.asistencia.entity.AsistenciaAlumnoDetalle;
import com.Mariategui.asistencia.repository.AsistenciaDetalleRepository;
import com.Mariategui.asistencia.service.AsistenciaDetalleService;

import java.util.List;
import java.util.Optional;

@Service
public class AsistenciaDetalleServiceImpl implements AsistenciaDetalleService {
    @Autowired
    private AsistenciaDetalleRepository asistenciaDetalleRepository;

    @Override
    public List<AsistenciaAlumnoDetalle> listar() {
        return asistenciaDetalleRepository.findAll();
    }

    @Override
    public AsistenciaAlumnoDetalle guardar(AsistenciaAlumnoDetalle asistenciaAlumnoDetalle) {
        return asistenciaDetalleRepository.save(asistenciaAlumnoDetalle);
    }

    @Override
    public AsistenciaAlumnoDetalle actualizar(AsistenciaAlumnoDetalle asistenciaAlumnoDetalle) {
        return asistenciaDetalleRepository.save(asistenciaAlumnoDetalle);
    }

    @Override
    public Optional<AsistenciaAlumnoDetalle> listarPorId(Integer id) {
        return asistenciaDetalleRepository.findById(id);
    }

    @Override
    public void eliminarPorId(Integer id) {
        asistenciaDetalleRepository.deleteById(id);
    }

}
