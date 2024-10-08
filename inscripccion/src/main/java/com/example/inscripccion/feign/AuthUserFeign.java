package com.example.inscripccion.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import com.example.inscripccion.dto.AuthUser;

@FeignClient(name = "auth-service", path = "/auth")
public interface AuthUserFeign {
    @GetMapping("/{id}")
    public ResponseEntity<AuthUser> listById(@PathVariable(required = true) Integer id);
}
