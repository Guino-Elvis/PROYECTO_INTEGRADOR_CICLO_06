package com.Mariategui.noticias.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Mariategui.noticias.entity.Slider;
import com.Mariategui.noticias.repository.SliderRepository;
import com.Mariategui.noticias.service.SliderService;

import java.util.List;
import java.util.Optional;

@Service
public class SliderServiceImpl implements SliderService {
    @Autowired
    private SliderRepository sliderRepository;

    @Override
    public List<Slider> listar() {
        return sliderRepository.findAll();
    }

    @Override
    public Slider guardar(Slider slider) {
        return sliderRepository.save(slider);
    }

    @Override
    public Slider actualizar(Slider slider) {
        return sliderRepository.save(slider);
    }

    @Override
    public Optional<Slider> listarPorId(Integer id) {
        return sliderRepository.findById(id);
    }

    @Override
    public void eliminarPorId(Integer id) {
        sliderRepository.deleteById(id);
    }
}
