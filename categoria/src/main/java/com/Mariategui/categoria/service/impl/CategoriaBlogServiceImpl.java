package com.Mariategui.categoria.service.impl;

import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Mariategui.categoria.entity.CategoriaBlog;
import com.Mariategui.categoria.repository.CategoriaBlogRepository;
import com.Mariategui.categoria.service.CategoriaBlogService;

@Service
public class CategoriaBlogServiceImpl implements CategoriaBlogService {

    @Autowired
    private CategoriaBlogRepository categoriaBlogRepository;

    @Override
    public List<CategoriaBlog> listar() {
        return categoriaBlogRepository.findAll();
    }

    @Override
    public CategoriaBlog guardar(CategoriaBlog categoriaBlog) {
        return categoriaBlogRepository.save(categoriaBlog);
    }

    @Override
    public CategoriaBlog actualizar(CategoriaBlog categoriaBlog) {
        return categoriaBlogRepository.save(categoriaBlog);
    }

    @Override
    public Optional<CategoriaBlog> listarPorId(Integer id) {
        return categoriaBlogRepository.findById(id);
    }

    @Override
    public void eliminarPorId(Integer id) {
        categoriaBlogRepository.deleteById(id);
    }
}
