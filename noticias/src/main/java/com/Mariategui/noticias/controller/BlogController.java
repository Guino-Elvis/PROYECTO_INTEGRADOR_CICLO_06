package com.Mariategui.noticias.controller;

import java.util.List;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.Mariategui.noticias.entity.Blog;
import com.Mariategui.noticias.service.BlogService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/blog")
public class BlogController {
    @Autowired
    private BlogService blogService;

    @GetMapping()
    public ResponseEntity<List<Blog>> list() {
        return ResponseEntity.ok().body(blogService.listar());
    }

    @PostMapping()
    public ResponseEntity<Blog> save(@RequestBody Blog blog) {
        return ResponseEntity.ok(blogService.guardar(blog));
    }

    @PutMapping()
    public ResponseEntity<Blog> update(@RequestBody Blog blog) {
        return ResponseEntity.ok(blogService.actualizar(blog));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Blog> listById(@PathVariable(required = true) Integer id) {
        return ResponseEntity.ok().body(blogService.listarPorId(id).get());
    }

    @DeleteMapping("/{id}")
    public String deleteById(@PathVariable(required = true) Integer id) {
        blogService.eliminarPorId(id);
        return "Eliminacion Correcta";
    }
}
