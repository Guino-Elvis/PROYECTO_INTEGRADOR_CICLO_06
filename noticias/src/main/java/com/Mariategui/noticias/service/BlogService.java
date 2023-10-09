package com.Mariategui.noticias.service;

import java.util.List;
import java.util.Optional;

import com.Mariategui.noticias.entity.Blog;

public interface BlogService {
    public List<Blog> listar();

    public Blog guardar(Blog blog);

    public Blog actualizar(Blog blog);

    public Optional<Blog> listarPorId(Integer id);

    public void eliminarPorId(Integer id);
}
