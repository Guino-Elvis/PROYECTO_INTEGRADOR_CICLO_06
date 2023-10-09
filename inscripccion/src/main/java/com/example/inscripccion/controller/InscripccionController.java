package com.example.inscripccion.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.inscripccion.entity.Inscripccion;
import com.example.inscripccion.service.InscripccionService;

import java.util.List;

@RestController
@RequestMapping("/inscripccion")
public class InscripccionController {
    @Autowired
    private InscripccionService inscripccionService;

    @GetMapping()
    public ResponseEntity<List<Inscripccion>> list() {
        return ResponseEntity.ok().body(inscripccionService.listar());
    }

    @PostMapping()
    public ResponseEntity<Inscripccion> save(@RequestBody Inscripccion inscripccion) {
        return ResponseEntity.ok(inscripccionService.guardar(inscripccion));
    }

    @PutMapping()
    public ResponseEntity<Inscripccion> update(@RequestBody Inscripccion inscripccion) {
        return ResponseEntity.ok(inscripccionService.actualizar(inscripccion));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Inscripccion> listById(@PathVariable(required = true) Integer id) {
        return ResponseEntity.ok().body(inscripccionService.listarPorId(id).get());
    }

    @DeleteMapping("/{id}")
    public String deleteById(@PathVariable(required = true) Integer id) {
        inscripccionService.eliminarPorId(id);
        return "Eliminacion Correcta";
    }
}
