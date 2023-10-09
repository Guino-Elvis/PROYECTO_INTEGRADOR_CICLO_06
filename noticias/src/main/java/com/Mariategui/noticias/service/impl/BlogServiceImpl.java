package com.Mariategui.noticias.service.impl;

import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Mariategui.noticias.dto.CategoriaBlog;
import com.Mariategui.noticias.entity.Blog;
import com.Mariategui.noticias.feign.CategoriaBlogFeign;
import com.Mariategui.noticias.repository.BlogRepository;
import com.Mariategui.noticias.service.BlogService;

@Service
public class BlogServiceImpl implements BlogService {
    @Autowired
    private BlogRepository blogRepository;

    @Autowired
    private CategoriaBlogFeign categoriaBlogFeign;

    @Override
    public List<Blog> listar() {
        return blogRepository.findAll();
    }

    @Override
    public Blog guardar(Blog blog) {
        return blogRepository.save(blog);
    }

    @Override
    public Blog actualizar(Blog blog) {
        return blogRepository.save(blog);
    }

    @Override
    public Optional<Blog> listarPorId(Integer id) {
        // Obtención del blog por su ID
        Blog blog = blogRepository.findById(id).get();
        if (blog != null) {
            System.out.println("Antes de la petición");
            // Obtención de la categoria asociado al blog
            CategoriaBlog categoriaBlog = categoriaBlogFeign.listById(blog.getCategoriaBlogId()).getBody();
            System.out.println("Después de la petición");
            System.out.println(categoriaBlog.toString());
            System.out.println(categoriaBlog.getTitulo());
            blog.setCategoriaBlog(categoriaBlog);
        }
        return Optional.ofNullable(blog);
    }

    @Override
    public void eliminarPorId(Integer id) {
        blogRepository.deleteById(id);
    }
}
