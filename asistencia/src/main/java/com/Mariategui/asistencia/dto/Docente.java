package com.Mariategui.asistencia.dto;

import lombok.Data;

@Data
public class Docente {
    private Integer id;
    private String nombre;
    private String apellido;
    private String dni;
    private String telefono;
    private String correo;
}
