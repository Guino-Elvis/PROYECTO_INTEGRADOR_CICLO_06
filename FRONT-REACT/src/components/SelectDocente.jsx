import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { API_URL } from '../config';
function SelectDocente({ onChange }) {
  const [docentes, setDocentes] = useState([]);
  const [selectedDocenteId, setSelectedDocenteId] = useState('');

  useEffect(() => {
    obtenerDocentes();
  }, []);

  const obtenerDocentes = () => {
    axios
      .get(`${API_URL}/docente`)
      .then((response) => {
        setDocentes(response.data);
      })
      .catch((error) => {
        console.log(error);
      });
  };

  const handleSeleccionarDocente = (event) => {
    const docenteId = event.target.value;
    setSelectedDocenteId(docenteId);
    onChange(docenteId);
  };

  return (
    <select value={selectedDocenteId} onChange={handleSeleccionarDocente}>
      <option value="">Seleccionar docente</option>
      {docentes.map((docente) => (
        <option key={docente.id} value={docente.id}>
          {docente.nombre}
        </option>
      ))}
    </select>
  );
}

export default SelectDocente;