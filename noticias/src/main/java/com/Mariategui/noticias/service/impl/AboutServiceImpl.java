package com.Mariategui.noticias.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Mariategui.noticias.entity.About;
import com.Mariategui.noticias.repository.AboutRepository;
import com.Mariategui.noticias.service.AboutService;

import java.util.List;
import java.util.Optional;

@Service
public class AboutServiceImpl implements AboutService {
    @Autowired
    private AboutRepository aboutRepository;

    @Override
    public List<About> listar() {
        return aboutRepository.findAll();
    }

    @Override
    public About guardar(About about) {
        return aboutRepository.save(about);
    }

    @Override
    public About actualizar(About about) {
        return aboutRepository.save(about);
    }

    @Override
    public Optional<About> listarPorId(Integer id) {
        return aboutRepository.findById(id);
    }

    @Override
    public void eliminarPorId(Integer id) {
        aboutRepository.deleteById(id);
    }
}
