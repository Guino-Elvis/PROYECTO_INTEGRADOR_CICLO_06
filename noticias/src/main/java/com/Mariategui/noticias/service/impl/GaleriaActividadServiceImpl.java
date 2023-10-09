package com.Mariategui.noticias.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Mariategui.noticias.entity.GaleriaActividad;
import com.Mariategui.noticias.repository.GaleriaActividadRepository;
import com.Mariategui.noticias.service.GaleriaActividadService;

import java.util.List;
import java.util.Optional;

@Service
public class GaleriaActividadServiceImpl implements GaleriaActividadService {
    @Autowired
    private GaleriaActividadRepository galeriaActividadRepository;

    @Override
    public List<GaleriaActividad> listar() {
        return galeriaActividadRepository.findAll();
    }

    @Override
    public GaleriaActividad guardar(GaleriaActividad galeriaActividad) {
        return galeriaActividadRepository.save(galeriaActividad);
    }

    @Override
    public GaleriaActividad actualizar(GaleriaActividad galeriaActividad) {
        return galeriaActividadRepository.save(galeriaActividad);
    }

    @Override
    public Optional<GaleriaActividad> listarPorId(Integer id) {
        return galeriaActividadRepository.findById(id);
    }

    @Override
    public void eliminarPorId(Integer id) {
        galeriaActividadRepository.deleteById(id);
    }
}
