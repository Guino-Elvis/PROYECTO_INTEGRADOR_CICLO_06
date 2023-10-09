package com.Mariategui.noticias.service;

import java.util.List;
import java.util.Optional;

import com.Mariategui.noticias.entity.GaleriaActividad;

public interface GaleriaActividadService {
    public List<GaleriaActividad> listar();

    public GaleriaActividad guardar(GaleriaActividad galeriaActividad);

    public GaleriaActividad actualizar(GaleriaActividad galeriaActividad);

    public Optional<GaleriaActividad> listarPorId(Integer id);

    public void eliminarPorId(Integer id);
}
