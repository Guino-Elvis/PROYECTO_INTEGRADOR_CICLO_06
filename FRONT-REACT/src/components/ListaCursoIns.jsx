import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { API_URL } from '../config';
function ListaCursoIns({ onChange }) {
  const [cursos, setCursos] = useState([]);
  const [selectedCursoId, setSelectedCursoId] = useState('');
 // token
 const token = localStorage.getItem("token");
 // end token
  useEffect(() => {
    obtenerCursos();
  }, []);

  const obtenerCursos = () => {
    axios
      .get(`${API_URL}/curso`,{
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((response) => {
        setCursos(response.data);
      })
      .catch((error) => {
        console.log(error);
      });
  };
  const handleSeleccionarCurso = (event) => {
    const cursoId = event.target.value;
    setSelectedCursoId(cursoId);
    onChange(cursoId);
  };

  return (
    <select value={selectedCursoId} onChange={handleSeleccionarCurso}>
      {cursos.map((curso) => (
        <option key={curso.id} value={curso.id}>
          {curso.nombre}  , S/. {curso.costo} 
        </option>
      ))}
    </select>
  );
}

export default ListaCursoIns;