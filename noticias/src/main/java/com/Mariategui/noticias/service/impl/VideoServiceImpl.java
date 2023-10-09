package com.Mariategui.noticias.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Mariategui.noticias.entity.Video;
import com.Mariategui.noticias.repository.VideoRepository;
import com.Mariategui.noticias.service.VideoService;

import java.util.List;
import java.util.Optional;

@Service
public class VideoServiceImpl implements VideoService {
    @Autowired
    private VideoRepository videoRepository;

    @Override
    public List<Video> listar() {
        return videoRepository.findAll();
    }

    @Override
    public Video guardar(Video video) {
        return videoRepository.save(video);
    }

    @Override
    public Video actualizar(Video video) {
        return videoRepository.save(video);
    }

    @Override
    public Optional<Video> listarPorId(Integer id) {
        return videoRepository.findById(id);
    }

    @Override
    public void eliminarPorId(Integer id) {
        videoRepository.deleteById(id);
    }
}
