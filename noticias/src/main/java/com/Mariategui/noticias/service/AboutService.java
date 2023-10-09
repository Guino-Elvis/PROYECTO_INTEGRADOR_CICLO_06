package com.Mariategui.noticias.service;

import java.util.List;
import java.util.Optional;

import com.Mariategui.noticias.entity.About;

public interface AboutService {
    public List<About> listar();

    public About guardar(About about);

    public About actualizar(About about);

    public Optional<About> listarPorId(Integer id);

    public void eliminarPorId(Integer id);
}
