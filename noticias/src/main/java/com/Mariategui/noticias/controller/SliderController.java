package com.Mariategui.noticias.controller;

import java.util.List;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.Mariategui.noticias.entity.Slider;
import com.Mariategui.noticias.service.SliderService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/slider")
public class SliderController {
    @Autowired
    private SliderService sliderService;

    @GetMapping()
    public ResponseEntity<List<Slider>> list() {
        return ResponseEntity.ok().body(sliderService.listar());
    }

    @PostMapping()
    public ResponseEntity<Slider> save(@RequestBody Slider slider) {
        return ResponseEntity.ok(sliderService.guardar(slider));
    }

    @PutMapping()
    public ResponseEntity<Slider> update(@RequestBody Slider slider) {
        return ResponseEntity.ok(sliderService.actualizar(slider));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Slider> listById(@PathVariable(required = true) Integer id) {
        return ResponseEntity.ok().body(sliderService.listarPorId(id).get());
    }

    @DeleteMapping("/{id}")
    public String deleteById(@PathVariable(required = true) Integer id) {
        sliderService.eliminarPorId(id);
        return "Eliminacion Correcta";
    }
}
