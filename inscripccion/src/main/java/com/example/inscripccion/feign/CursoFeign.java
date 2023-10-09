package com.example.inscripccion.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.example.inscripccion.dto.Curso;

@FeignClient(name = "curso-service", path = "/curso")

public interface CursoFeign {
    @GetMapping("/{id}")
    public ResponseEntity<Curso> listById(@PathVariable(required = true) Integer id);
}
// ss