package com.Mariategui.asistencia.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.Mariategui.asistencia.dto.Docente;

@FeignClient(name = "docente-service", path = "/docente")
public interface DocenteFeign {
    @GetMapping("/{id}")
    public ResponseEntity<Docente> listById(@PathVariable(required = true) Integer id);
}
