package com.example.inscripccion.dto;

import lombok.Data;

@Data
public class Alumno {
    private Integer id;
    private String nombre;
    private String apellido;
    private String dni;
    private String codigo;
    private String correo; // ss
}
