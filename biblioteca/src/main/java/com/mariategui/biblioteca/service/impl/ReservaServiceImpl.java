package com.mariategui.biblioteca.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mariategui.biblioteca.dto.AuthUser;
import com.mariategui.biblioteca.entity.Libro;
import com.mariategui.biblioteca.entity.Prestamo;
import com.mariategui.biblioteca.entity.Reserva;
import com.mariategui.biblioteca.feign.AuthUserFeign;
import com.mariategui.biblioteca.repository.ReservaRepository;
import com.mariategui.biblioteca.service.ReservaService;

@Service
public class ReservaServiceImpl implements ReservaService {

    @Autowired
    private AuthUserFeign authUserFeign;

    @Autowired
    private LibroServiceImpl libroService; // Cambio en la inyección de dependencia

    @Autowired
    private ReservaRepository reservaRepository;

    @Override
    public List<Reserva> listar() {
        return reservaRepository.findAll();
    }

    @Override
    public Reserva guardar(Reserva reserva) {
        return reservaRepository.save(reserva);
    }

    @Override
    public Reserva actualizar(Reserva reserva) {
        return reservaRepository.save(reserva);
    }

    // @Override
    // public Optional<Reserva> listarPorId(Integer id) {
    // return reservaRepository.findById(id);
    // }

    @Override
    public Optional<Reserva> listarPorId(Integer id) {
        Reserva reserva = reservaRepository.findById(id).orElse(null);
        if (reserva != null) {
            System.out.println("Antes de la petición");
            Optional<Libro> libroOptional = libroService.listarPorId(reserva.getLibro().getId());
            if (libroOptional.isPresent()) {
                Libro libro = libroOptional.get();
                System.out.println("Después de la petición del libro");
                System.out.println(libro.toString());
                System.out.println(libro.getTitulo());
                System.out.println(libro.getId());
                reserva.setLibro(libro);
            }

            AuthUser authUser = authUserFeign.listById(reserva.getUserId()).getBody();
            if (authUser != null) {
                System.out.println("Después de la petición de AuthUser");
                System.out.println(authUser.toString());
                System.out.println(authUser.getName());
                reserva.setAuthUser(authUser);
            }
        }

        return Optional.ofNullable(reserva);
    }

    @Override
    public void eliminarPorId(Integer id) {
        reservaRepository.deleteById(id);
    }
}
