package com.mariategui.biblioteca.service.impl;

import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mariategui.biblioteca.entity.CategoriaLib;
import com.mariategui.biblioteca.entity.Libro;
import com.mariategui.biblioteca.repository.LibroRepository;
import com.mariategui.biblioteca.service.LibroService;

@Service
public class LibroServiceImpl implements LibroService {

    @Autowired
    private CategoriaLibServiceImpl categoriaLibService;

    @Autowired
    private LibroRepository libroRepository;

    @Override
    public List<Libro> listar() {
        return libroRepository.findAll();
    }

    @Override
    public Libro guardar(Libro libro) {
        return libroRepository.save(libro);
    }

    @Override
    public Libro actualizar(Libro libro) {
        return libroRepository.save(libro);
    }

    @Override
    public Optional<Libro> listarPorId(Integer id) {
        // obtener del producto su id
        Libro libro = libroRepository.findById(id).orElse(null);
        if (libro != null) {
            System.out.println("Antes de la petición");
            // Obtención de la categoría asociada al libro
            Optional<CategoriaLib> categoriaOptional = categoriaLibService.listarPorId(libro.getCategorialib().getId());
            categoriaOptional.ifPresent(categoriaLib -> {
                System.out.println("Después de la petición");
                System.out.println(categoriaLib.toString());
                System.out.println(categoriaLib.getTitulo());
                System.out.println(categoriaLib.getId());
                libro.setCategorialib(categoriaLib);
            });
        }

        return Optional.ofNullable(libro);
    }

    @Override
    public void eliminarPorId(Integer id) {
        libroRepository.deleteById(id);
    }
}
