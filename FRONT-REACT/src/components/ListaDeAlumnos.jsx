import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { API_URL } from '../config';

function ListaDeAlumnos({ onChange, selectedAlumnoId }) {
  const [alumnos, setAlumnos] = useState([]);
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

  const handleAlumnoSelection = (alumnoId, checked) => {
    onChange(alumnoId, checked);
  };

  return (
    <div>
      {alumnos.map((alumno) => (
        <div key={alumno.id}>
          <label>
            <input
              type="checkbox"
              onChange={(e) => handleAlumnoSelection(alumno.id, e.target.checked)}
              checked={selectedAlumnoId.includes(alumno.id)}
            />
            {alumno.nombre}
          </label>
        </div>
      ))}
    </div>
  );
}

export default ListaDeAlumnos;