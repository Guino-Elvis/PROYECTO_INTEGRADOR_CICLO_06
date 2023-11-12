// package com.Mariategui.asistencia.feign;

// import org.springframework.cloud.openfeign.FeignClient;
// import org.springframework.http.ResponseEntity;
// import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.PathVariable;

// import com.Mariategui.asistencia.dto.Alumno;

// @FeignClient(name = "alumno-service", path = "/alumno")
// public interface AlumnoFeign {
// @GetMapping("/{id}")
// public ResponseEntity<Alumno> listById(@PathVariable(required = true) Integer
// id);
// }// casoooos