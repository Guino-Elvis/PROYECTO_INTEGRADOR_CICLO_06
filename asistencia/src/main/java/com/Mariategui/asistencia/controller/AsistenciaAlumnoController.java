package com.Mariategui.asistencia.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.Mariategui.asistencia.entity.AsistenciaAlumno;
import com.Mariategui.asistencia.service.AsistenciaAlumnoService;

import java.util.List;

@RestController
@RequestMapping("/asistencia")
public class AsistenciaAlumnoController {
    @Autowired
    private AsistenciaAlumnoService asistenciaAlumnoService;

    @GetMapping()
    public ResponseEntity<List<AsistenciaAlumno>> list() {
        return ResponseEntity.ok().body(asistenciaAlumnoService.listar());
    }

    @PostMapping()
    public ResponseEntity<AsistenciaAlumno> save(@RequestBody AsistenciaAlumno asistenciaAlumno) {
        return ResponseEntity.ok(asistenciaAlumnoService.guardar(asistenciaAlumno));
    }

    @PutMapping()
    public ResponseEntity<AsistenciaAlumno> update(@RequestBody AsistenciaAlumno asistenciaAlumno) {
        return ResponseEntity.ok(asistenciaAlumnoService.actualizar(asistenciaAlumno));
    }

    @GetMapping("/{id}")
    public ResponseEntity<AsistenciaAlumno> listById(@PathVariable(required = true) Integer id) {
        return ResponseEntity.ok().body(asistenciaAlumnoService.listarPorId(id).get());
    }

    @DeleteMapping("/{id}")
    public String deleteById(@PathVariable(required = true) Integer id) {
        asistenciaAlumnoService.eliminarPorId(id);
        return "Eliminacion Correcta";
    }
}
