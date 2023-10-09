package com.Mariategui.noticias.service;

import java.util.List;
import java.util.Optional;

import com.Mariategui.noticias.entity.Slider;

public interface SliderService {

    public List<Slider> listar();

    public Slider guardar(Slider slider);

    public Slider actualizar(Slider slider);

    public Optional<Slider> listarPorId(Integer id);

    public void eliminarPorId(Integer id);
}
