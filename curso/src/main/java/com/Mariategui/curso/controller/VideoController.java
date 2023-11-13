package com.Mariategui.curso.controller;

import java.util.List;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.Mariategui.curso.entity.Video;
import com.Mariategui.curso.service.VideoService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/video")

public class VideoController {
    @Autowired
    private VideoService videoService;

    @GetMapping()
    public ResponseEntity<List<Video>> list() {
        return ResponseEntity.ok().body(videoService.listar());
    }

    @PostMapping()
    public ResponseEntity<Video> save(@RequestBody Video video) {
        return ResponseEntity.ok(videoService.guardar(video));
    }

    @PutMapping()
    public ResponseEntity<Video> update(@RequestBody Video video) {
        return ResponseEntity.ok(videoService.actualizar(video));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Video> listById(@PathVariable(required = true) Integer id) {
        return ResponseEntity.ok().body(videoService.listarPorId(id).get());
    }

    @DeleteMapping("/{id}")
    public String deleteById(@PathVariable(required = true) Integer id) {
        videoService.eliminarPorId(id);
        return "Eliminacion Correcta";
    }
}
