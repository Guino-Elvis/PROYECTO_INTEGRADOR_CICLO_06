package com.Mariategui.noticias.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.Mariategui.noticias.entity.About;
import com.Mariategui.noticias.service.AboutService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/about")
public class AboutController {
    @Autowired
    private AboutService aboutService;

    @GetMapping()
    public ResponseEntity<List<About>> list() {
        return ResponseEntity.ok().body(aboutService.listar());
    }

    @PostMapping()
    public ResponseEntity<About> save(@RequestBody About about) {
        return ResponseEntity.ok(aboutService.guardar(about));
    }

    @PutMapping()
    public ResponseEntity<About> update(@RequestBody About about) {
        return ResponseEntity.ok(aboutService.actualizar(about));
    }

    @GetMapping("/{id}")
    public ResponseEntity<About> listById(@PathVariable(required = true) Integer id) {
        return ResponseEntity.ok().body(aboutService.listarPorId(id).get());
    }

    @DeleteMapping("/{id}")
    public String deleteById(@PathVariable(required = true) Integer id) {
        aboutService.eliminarPorId(id);
        return "Eliminacion Correcta";
    }
}
