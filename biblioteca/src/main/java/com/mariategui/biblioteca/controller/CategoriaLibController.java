package com.mariategui.biblioteca.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mariategui.biblioteca.entity.CategoriaLib;
import com.mariategui.biblioteca.service.CategoriaLibService;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/categorialib")

public class CategoriaLibController {
    @Autowired
    private CategoriaLibService categoriaLibService;

    @GetMapping()
    public ResponseEntity<List<CategoriaLib>> list() {
        return ResponseEntity.ok().body(categoriaLibService.listar());
    }

    @PostMapping()
    public ResponseEntity<CategoriaLib> save(@RequestBody CategoriaLib categoriaLib) {
        return ResponseEntity.ok(categoriaLibService.guardar(categoriaLib));
    }

    @PutMapping()
    public ResponseEntity<CategoriaLib> update(@RequestBody CategoriaLib categoriaLib) {
        return ResponseEntity.ok(categoriaLibService.actualizar(categoriaLib));
    }

    @GetMapping("/{id}")
    public ResponseEntity<CategoriaLib> listById(@PathVariable(required = true) Integer id) {
        return ResponseEntity.ok().body(categoriaLibService.listarPorId(id).get());
    }

    @DeleteMapping("/{id}")
    public String deleteById(@PathVariable(required = true) Integer id) {
        categoriaLibService.eliminarPorId(id);
        return "Eliminacion Correcta";
    }
}
