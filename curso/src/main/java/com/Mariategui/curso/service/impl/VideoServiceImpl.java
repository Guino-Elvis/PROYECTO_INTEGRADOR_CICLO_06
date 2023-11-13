package com.Mariategui.curso.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Mariategui.curso.entity.Video;
import com.Mariategui.curso.repository.VideoRepository;
import com.Mariategui.curso.service.VideoService;

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
