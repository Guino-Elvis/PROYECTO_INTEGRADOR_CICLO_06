package com.Mariategui.docente.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.Mariategui.docente.entity.Docente;
import com.Mariategui.docente.service.DocenteService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
// @CrossOrigin(origins = "*", methods = { RequestMethod.GET,
// RequestMethod.POST, RequestMethod.PUT,
// RequestMethod.DELETE })
@RequestMapping("/docente")
public class DocenteController {
    @Autowired
    private DocenteService docenteService;

    @GetMapping()
    public ResponseEntity<List<Docente>> list() {
        return ResponseEntity.ok().body(docenteService.listar());
    }

    @PostMapping()
    public ResponseEntity<Docente> save(@RequestBody Docente docente) {
        return ResponseEntity.ok(docenteService.guardar(docente));
    }

    @PutMapping()
    public ResponseEntity<Docente> update(@RequestBody Docente docente) {
        return ResponseEntity.ok(docenteService.actualizar(docente));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Docente> listById(@PathVariable(required = true) Integer id) {
        return ResponseEntity.ok().body(docenteService.listarPorId(id).get());
    }

    @DeleteMapping("/{id}")
    public String deleteById(@PathVariable(required = true) Integer id) {
        docenteService.eliminarPorId(id);
        return "Eliminacion Correcta";
    }
}
