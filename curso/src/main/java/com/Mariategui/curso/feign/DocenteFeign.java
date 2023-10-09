package com.Mariategui.curso.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.Mariategui.curso.dto.Docente;

@FeignClient(name = "docente-service", path = "/docente")
public interface DocenteFeign {
    @GetMapping("/{id}")
    public ResponseEntity<Docente> listById(@PathVariable(required = true) Integer id);
}
