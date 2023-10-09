package com.Mariategui.noticias.controller;

import java.util.List;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.Mariategui.noticias.entity.GaleriaActividad;
import com.Mariategui.noticias.service.GaleriaActividadService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/galeriaactividad")

public class GaleriaActividadController {
    @Autowired
    private GaleriaActividadService galeriaActividadService;

    @GetMapping()
    public ResponseEntity<List<GaleriaActividad>> list() {
        return ResponseEntity.ok().body(galeriaActividadService.listar());
    }

    @PostMapping()
    public ResponseEntity<GaleriaActividad> save(@RequestBody GaleriaActividad galeriaActividad) {
        return ResponseEntity.ok(galeriaActividadService.guardar(galeriaActividad));
    }

    @PutMapping()
    public ResponseEntity<GaleriaActividad> update(@RequestBody GaleriaActividad galeriaActividad) {
        return ResponseEntity.ok(galeriaActividadService.actualizar(galeriaActividad));
    }

    @GetMapping("/{id}")
    public ResponseEntity<GaleriaActividad> listById(@PathVariable(required = true) Integer id) {
        return ResponseEntity.ok().body(galeriaActividadService.listarPorId(id).get());
    }

    @DeleteMapping("/{id}")
    public String deleteById(@PathVariable(required = true) Integer id) {
        galeriaActividadService.eliminarPorId(id);
        return "Eliminacion Correcta";
    }
}
