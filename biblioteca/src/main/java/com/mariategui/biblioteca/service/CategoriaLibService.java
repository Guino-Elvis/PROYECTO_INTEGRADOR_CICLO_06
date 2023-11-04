package com.mariategui.biblioteca.service;

import java.util.List;
import java.util.Optional;

import com.mariategui.biblioteca.entity.CategoriaLib;

public interface CategoriaLibService {

    public List<CategoriaLib> listar();

    public CategoriaLib guardar(CategoriaLib categoriaLib);

    public CategoriaLib actualizar(CategoriaLib categoriaLib);

    public Optional<CategoriaLib> listarPorId(Integer id);

    public void eliminarPorId(Integer id);
}
