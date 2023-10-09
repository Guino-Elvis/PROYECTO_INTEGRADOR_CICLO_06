package com.Mariategui.asistencia.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Mariategui.asistencia.entity.Horario;
import com.Mariategui.asistencia.repository.HorarioRepository;
import com.Mariategui.asistencia.service.HorarioService;

import java.util.List;
import java.util.Optional;

@Service
public class HorarioServiceImpl implements HorarioService {
    @Autowired
    private HorarioRepository horarioRepository;

    @Override
    public List<Horario> listar() {
        return horarioRepository.findAll();
    }

    @Override
    public Horario guardar(Horario horario) {
        return horarioRepository.save(horario);
    }

    @Override
    public Horario actualizar(Horario horario) {
        return horarioRepository.save(horario);
    }

    @Override
    public Optional<Horario> listarPorId(Integer id) {
        return horarioRepository.findById(id);
    }

    @Override
    public void eliminarPorId(Integer id) {
        horarioRepository.deleteById(id);
    }
}
