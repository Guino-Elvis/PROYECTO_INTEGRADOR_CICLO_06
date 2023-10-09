package com.Mariategui.noticias.service;

import java.util.List;
import java.util.Optional;

import com.Mariategui.noticias.entity.GaleriaUbicacion;

public interface GaleriaUbicacionService {
    public List<GaleriaUbicacion> listar();

    public GaleriaUbicacion guardar(GaleriaUbicacion galeriaUbicacion);

    public GaleriaUbicacion actualizar(GaleriaUbicacion galeriaUbicacion);

    public Optional<GaleriaUbicacion> listarPorId(Integer id);

    public void eliminarPorId(Integer id);
}
