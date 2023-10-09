package com.Mariategui.noticias.service;

import java.util.List;
import java.util.Optional;

import com.Mariategui.noticias.entity.Video;

public interface VideoService {
    public List<Video> listar();

    public Video guardar(Video video);

    public Video actualizar(Video video);

    public Optional<Video> listarPorId(Integer id);

    public void eliminarPorId(Integer id);
}
