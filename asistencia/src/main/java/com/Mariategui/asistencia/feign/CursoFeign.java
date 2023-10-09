package com.Mariategui.asistencia.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.Mariategui.asistencia.dto.Curso;

@FeignClient(name = "curso-service", path = "/curso")

public interface CursoFeign {
    @GetMapping("/{id}")
    public ResponseEntity<Curso> listById(@PathVariable(required = true) Integer id);
}
// ss