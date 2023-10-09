package com.Mariategui.noticias.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.Mariategui.noticias.dto.CategoriaBlog;

@FeignClient(name = "categoria-service", path = "/categoriablog")
public interface CategoriaBlogFeign {
    @GetMapping("/{id}")
    public ResponseEntity<CategoriaBlog> listById(@PathVariable(required = true) Integer id);
}
