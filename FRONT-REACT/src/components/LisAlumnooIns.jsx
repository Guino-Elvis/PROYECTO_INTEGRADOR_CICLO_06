import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { API_URL } from '../config';
function LisAlumnoIns({ onChange }) {
  const [alumnos, setAlumnos] = useState([]);
  const [selectedAlumnoId, setSelectedAlumnoId] = useState('');
 // token
 const token = localStorage.getItem("token");
 // end token
  useEffect(() => {
    obtenerAlumnos();
  }, []);

  const obtenerAlumnos = () => {
    axios
      .get(`${API_URL}/alumno`,{
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((response) => {
        setAlumnos(response.data);
      })
      .catch((error) => {
        console.log(error);
      });
  };
  const handleSeleccionarAlumno = (event) => {
    const alumnoId = event.target.value;
    setSelectedAlumnoId(alumnoId);
    onChange(alumnoId);
  };

  return (
    <select value={selectedAlumnoId} onChange={handleSeleccionarAlumno}>
      {alumnos.map((alumno) => (
        <option key={alumno.id} value={alumno.id}>
          {alumno.nombre} 
        </option>
      ))}
    </select>
  );
}

export default LisAlumnoIns;