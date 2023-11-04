package com.mariategui.biblioteca.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mariategui.biblioteca.dto.AuthUser;
import com.mariategui.biblioteca.entity.CategoriaLib;
import com.mariategui.biblioteca.entity.Libro;
import com.mariategui.biblioteca.entity.Prestamo;
import com.mariategui.biblioteca.feign.AuthUserFeign;
import com.mariategui.biblioteca.repository.PrestamosRepository;
import com.mariategui.biblioteca.service.PrestamoService;

@Service
public class PrestamoServiceImpl implements PrestamoService {

    @Autowired
    private AuthUserFeign authUserFeign;

    @Autowired
    private LibroServiceImpl libroService; // Cambio en la inyección de dependencia

    @Autowired
    private PrestamosRepository prestamoRepository;

    @Override
    public List<Prestamo> listar() {
        return prestamoRepository.findAll();
    }

    @Override
    public Prestamo guardar(Prestamo prestamo) {
        return prestamoRepository.save(prestamo);
    }

    @Override
    public Prestamo actualizar(Prestamo prestamo) {
        return prestamoRepository.save(prestamo);
    }

    // @Override
    // public Optional<Prestamo> listarPorId(Integer id) {
    // // obtener del producto su id
    // Prestamo prestamo = prestamoRepository.findById(id).orElse(null);
    // if (prestamo != null) {
    // System.out.println("Antes de la petición");
    // // Obtención de la categoría asociada al libro
    // Optional<Libro> libroOptional =
    // libroService.listarPorId(prestamo.getLibro().getId());
    // AuthUser authUser = authUserFeign.listById(prestamo.getUserId()).getBody();
    // libroOptional.ifPresent(libro -> {
    // System.out.println("Después de la petición");
    // System.out.println(libro.toString());
    // System.out.println(libro.getTitulo());
    // System.out.println(libro.getId());
    // prestamo.setLibro(libro);
    // prestamo.setAuthUser(authUser);
    // System.out.println(authUser.toString());
    // System.out.println(authUser.getName());
    // System.out.println(authUser.getName());
    // });
    // }

    // return Optional.ofNullable(prestamo);
    // }

    @Override
    public Optional<Prestamo> listarPorId(Integer id) {
        Prestamo prestamo = prestamoRepository.findById(id).orElse(null);
        if (prestamo != null) {
            System.out.println("Antes de la petición");
            Optional<Libro> libroOptional = libroService.listarPorId(prestamo.getLibro().getId());
            if (libroOptional.isPresent()) {
                Libro libro = libroOptional.get();
                System.out.println("Después de la petición del libro");
                System.out.println(libro.toString());
                System.out.println(libro.getTitulo());
                System.out.println(libro.getId());
                prestamo.setLibro(libro);
            }

            AuthUser authUser = authUserFeign.listById(prestamo.getUserId()).getBody();
            if (authUser != null) {
                System.out.println("Después de la petición de AuthUser");
                System.out.println(authUser.toString());
                System.out.println(authUser.getName());
                prestamo.setAuthUser(authUser);
            }
        }

        return Optional.ofNullable(prestamo);
    }

    @Override
    public void eliminarPorId(Integer id) {
        prestamoRepository.deleteById(id);
    }
}
