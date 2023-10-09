package com.Mariategui.asistencia.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.Mariategui.asistencia.entity.Horario;
import com.Mariategui.asistencia.service.HorarioService;

import java.util.List;

@RestController
@RequestMapping("/horario")
public class HorarioController {
    @Autowired
    private HorarioService horarioService;

    @GetMapping()
    public ResponseEntity<List<Horario>> list() {
        return ResponseEntity.ok().body(horarioService.listar());
    }

    @PostMapping()
    public ResponseEntity<Horario> save(@RequestBody Horario horario) {
        return ResponseEntity.ok(horarioService.guardar(horario));
    }

    @PutMapping()
    public ResponseEntity<Horario> update(@RequestBody Horario horario) {
        return ResponseEntity.ok(horarioService.actualizar(horario));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Horario> listById(@PathVariable(required = true) Integer id) {
        return ResponseEntity.ok().body(horarioService.listarPorId(id).get());
    }

    @DeleteMapping("/{id}")
    public String deleteById(@PathVariable(required = true) Integer id) {
        horarioService.eliminarPorId(id);
        return "Eliminacion Correcta";
    }
}
