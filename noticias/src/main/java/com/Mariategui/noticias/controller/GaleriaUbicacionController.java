package com.Mariategui.noticias.controller;

import java.util.List;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.Mariategui.noticias.entity.GaleriaUbicacion;
import com.Mariategui.noticias.service.GaleriaUbicacionService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/galeriaubicacion")

public class GaleriaUbicacionController {
    @Autowired
    private GaleriaUbicacionService galeriaUbicacionService;

    @GetMapping()
    public ResponseEntity<List<GaleriaUbicacion>> list() {
        return ResponseEntity.ok().body(galeriaUbicacionService.listar());
    }

    @PostMapping()
    public ResponseEntity<GaleriaUbicacion> save(@RequestBody GaleriaUbicacion galeriaUbicacion) {
        return ResponseEntity.ok(galeriaUbicacionService.guardar(galeriaUbicacion));
    }

    @PutMapping()
    public ResponseEntity<GaleriaUbicacion> update(@RequestBody GaleriaUbicacion galeriaUbicacion) {
        return ResponseEntity.ok(galeriaUbicacionService.actualizar(galeriaUbicacion));
    }

    @GetMapping("/{id}")
    public ResponseEntity<GaleriaUbicacion> listById(@PathVariable(required = true) Integer id) {
        return ResponseEntity.ok().body(galeriaUbicacionService.listarPorId(id).get());
    }

    @DeleteMapping("/{id}")
    public String deleteById(@PathVariable(required = true) Integer id) {
        galeriaUbicacionService.eliminarPorId(id);
        return "Eliminacion Correcta";
    }
}
