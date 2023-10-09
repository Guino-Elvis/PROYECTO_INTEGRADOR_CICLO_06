import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { API_URL } from '../config';
function SelectHorario({ onChange}) {
  const [horarios, setHorarios] = useState([]);
  const [selectedHorarioId, setSelectedHorarioId] = useState('');
  // token
  const token = localStorage.getItem("token");
  // end token
  useEffect(() => {
    obtenerHorarios();
  }, []);

  const obtenerHorarios = () => {
    axios
      .get(`${API_URL}/horario`,{
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((response) => {
        setHorarios(response.data);
      })
      .catch((error) => {
        console.log(error);
      });
  };

  const handleSeleccionarHorario = (event ) => {
    const horarioId = event.target.value;
    setSelectedHorarioId(horarioId);
    onChange(horarioId);
  };

  return (
    <select value={selectedHorarioId} onChange={handleSeleccionarHorario}>
      {horarios.map((horario) => (
        <option key={horario.id} value={horario.id}>
          {horario.nombre} | {horario.hora}
        </option>
      ))}
    </select>
  );
}

export default SelectHorario;