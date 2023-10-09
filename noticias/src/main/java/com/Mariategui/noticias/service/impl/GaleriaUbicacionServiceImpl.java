package com.Mariategui.noticias.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Mariategui.noticias.entity.GaleriaUbicacion;
import com.Mariategui.noticias.repository.GaleriaUbicacionRepository;
import com.Mariategui.noticias.service.GaleriaUbicacionService;

import java.util.List;
import java.util.Optional;

@Service
public class GaleriaUbicacionServiceImpl implements GaleriaUbicacionService {
    @Autowired
    private GaleriaUbicacionRepository galeriaUbicacionRepository;

    @Override
    public List<GaleriaUbicacion> listar() {
        return galeriaUbicacionRepository.findAll();
    }

    @Override
    public GaleriaUbicacion guardar(GaleriaUbicacion galeriaUbicacion) {
        return galeriaUbicacionRepository.save(galeriaUbicacion);
    }

    @Override
    public GaleriaUbicacion actualizar(GaleriaUbicacion galeriaUbicacion) {
        return galeriaUbicacionRepository.save(galeriaUbicacion);
    }

    @Override
    public Optional<GaleriaUbicacion> listarPorId(Integer id) {
        return galeriaUbicacionRepository.findById(id);
    }

    @Override
    public void eliminarPorId(Integer id) {
        galeriaUbicacionRepository.deleteById(id);
    }
}
