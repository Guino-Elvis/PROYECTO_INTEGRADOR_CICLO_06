package com.mariategui.biblioteca.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mariategui.biblioteca.entity.CategoriaLib;
import com.mariategui.biblioteca.repository.CategoriaLibRepository;
import com.mariategui.biblioteca.service.CategoriaLibService;

@Service
public class CategoriaLibServiceImpl implements CategoriaLibService {
    @Autowired
    private CategoriaLibRepository categoriaLibRepository;

    @Override
    public List<CategoriaLib> listar() {
        return categoriaLibRepository.findAll();
    }

    @Override
    public CategoriaLib guardar(CategoriaLib categoriaLib) {
        return categoriaLibRepository.save(categoriaLib);
    }

    @Override
    public CategoriaLib actualizar(CategoriaLib categoriaLib) {
        return categoriaLibRepository.save(categoriaLib);
    }

    @Override
    public Optional<CategoriaLib> listarPorId(Integer id) {
        return categoriaLibRepository.findById(id);
    }

    @Override
    public void eliminarPorId(Integer id) {
        categoriaLibRepository.deleteById(id);
    }
}
