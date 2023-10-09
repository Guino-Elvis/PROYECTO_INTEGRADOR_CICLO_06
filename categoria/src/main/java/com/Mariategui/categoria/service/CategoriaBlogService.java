package com.Mariategui.categoria.service;

import java.util.List;
import java.util.Optional;

import com.Mariategui.categoria.entity.CategoriaBlog;

public interface CategoriaBlogService {

    public List<CategoriaBlog> listar();

    public CategoriaBlog guardar(CategoriaBlog categoriaBlog);

    public CategoriaBlog actualizar(CategoriaBlog categoriaBlog);

    public Optional<CategoriaBlog> listarPorId(Integer id);

    public void eliminarPorId(Integer id);
}
