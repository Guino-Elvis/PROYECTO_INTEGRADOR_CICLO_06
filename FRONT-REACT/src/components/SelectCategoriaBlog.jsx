import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { API_URL } from '../config';
function SelectCategoriaBlog({ onChange }) {
  const [categoriaBlogs, setCategoriaBlogs] = useState([]);
  const [selectedCategoriaBlogId, setSelectedCategoriaBlogId] = useState('');

  useEffect(() => {
    obtenerCategoriaBlogs();
  }, []);

  const obtenerCategoriaBlogs = () => {
    axios
      .get(`${API_URL}/categoriablog`)
      .then((response) => {
        setCategoriaBlogs(response.data);
      })
      .catch((error) => {
        console.log(error);
      });
  };

  const handleSeleccionarCategoriaBlog = (event) => {
    const categoriaBlogId = event.target.value;
    setSelectedCategoriaBlogId(categoriaBlogId);
    onChange(categoriaBlogId);
  };

  return (
    <select value={selectedCategoriaBlogId} onChange={handleSeleccionarCategoriaBlog}>
      <option value="">Seleccionar CategoriaBlog</option>
      {categoriaBlogs.map((categoriaBlog) => (
        <option key={categoriaBlog.id} value={categoriaBlog.id}>
          {categoriaBlog.titulo}
        </option>
      ))}
    </select>
  );
}

export default SelectCategoriaBlog;