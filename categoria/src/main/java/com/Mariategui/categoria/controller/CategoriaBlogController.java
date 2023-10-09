package com.Mariategui.categoria.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.Mariategui.categoria.entity.CategoriaBlog;
import com.Mariategui.categoria.service.CategoriaBlogService;

import java.util.List;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;

@RestController
@RequestMapping("/categoriablog")
public class CategoriaBlogController {
    @Autowired
    private CategoriaBlogService categoriaBlogService;

    @GetMapping()
    public ResponseEntity<List<CategoriaBlog>> list() {
        return ResponseEntity.ok().body(categoriaBlogService.listar());
    }

    @PostMapping()
    public ResponseEntity<CategoriaBlog> save(@RequestBody CategoriaBlog categoriaBlog) {
        return ResponseEntity.ok(categoriaBlogService.guardar(categoriaBlog));
    }

    @PutMapping()
    public ResponseEntity<CategoriaBlog> update(@RequestBody CategoriaBlog categoriaBlog) {
        return ResponseEntity.ok(categoriaBlogService.actualizar(categoriaBlog));
    }

    @GetMapping("/{id}")
    public ResponseEntity<CategoriaBlog> listById(@PathVariable(required = true) Integer id) {
        return ResponseEntity.ok().body(categoriaBlogService.listarPorId(id).get());
    }

    @DeleteMapping("/{id}")
    public String deleteById(@PathVariable(required = true) Integer id) {
        categoriaBlogService.eliminarPorId(id);
        return "Eliminacion Correcta";
    }
}
