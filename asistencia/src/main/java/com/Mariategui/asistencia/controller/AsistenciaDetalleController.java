package com.Mariategui.asistencia.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.Mariategui.asistencia.entity.AsistenciaAlumnoDetalle;
import com.Mariategui.asistencia.service.AsistenciaDetalleService;

import java.util.List;

@RestController
@RequestMapping("/detalleasistencia")
public class AsistenciaDetalleController {
    @Autowired
    private AsistenciaDetalleService asistenciaDetalleService;

    @GetMapping()
    public ResponseEntity<List<AsistenciaAlumnoDetalle>> list() {
        return ResponseEntity.ok().body(asistenciaDetalleService.listar());
    }

    @PostMapping()
    public ResponseEntity<AsistenciaAlumnoDetalle> save(@RequestBody AsistenciaAlumnoDetalle asistenciaAlumnoDetalle) {
        return ResponseEntity.ok(asistenciaDetalleService.guardar(asistenciaAlumnoDetalle));
    }

    @PutMapping()
    public ResponseEntity<AsistenciaAlumnoDetalle> update(
            @RequestBody AsistenciaAlumnoDetalle asistenciaAlumnoDetalle) {
        return ResponseEntity.ok(asistenciaDetalleService.actualizar(asistenciaAlumnoDetalle));
    }

    @GetMapping("/{id}")
    public ResponseEntity<AsistenciaAlumnoDetalle> listById(@PathVariable(required = true) Integer id) {
        return ResponseEntity.ok().body(asistenciaDetalleService.listarPorId(id).get());
    }

    @DeleteMapping("/{id}")
    public String deleteById(@PathVariable(required = true) Integer id) {
        asistenciaDetalleService.eliminarPorId(id);
        return "Eliminacion Correcta";
    }
}
