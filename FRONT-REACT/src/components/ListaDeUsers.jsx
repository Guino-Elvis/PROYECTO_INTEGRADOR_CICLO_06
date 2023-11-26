import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { API_URL } from '../config';

const ListaDeUsers = ({ onChange, selectedUserId }) => {
  const [users, setUsers] = useState([]);
  const [checkedUsers, setCheckedUsers] = useState([]);

  // token
  const token = localStorage.getItem("token");
  // end token

  useEffect(() => {
    obtenerUsers();
  }, []);

  const obtenerUsers = () => {
    axios
      .get(`${API_URL}/auth/list`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((response) => {
        setUsers(response.data);

        // Configurar checkedUsers al obtener datos
        const initialCheckedUsers = response.data
          .filter((user) => selectedUserId.includes(user.id))
          .map((user) => user.id);
        setCheckedUsers(initialCheckedUsers);
      })
      .catch((error) => {
        console.log(error);
      });
  };

  const handleUserSelection = (userId, checked) => {
    const updatedCheckedUsers = checked
      ? [...checkedUsers, userId]
      : checkedUsers.filter((id) => id !== userId);

    setCheckedUsers(updatedCheckedUsers);

    // Aquí puedes agregar un console.log para verificar que userId y checked se estén pasando correctamente
    // console.log('Usuario seleccionado:', userId, 'Estado del checkbox:', checked);

    // Actualizar la base de datos llamando a onChange
    onChange(userId, checked ? 1 : 0);
  };

  return (
    <div>
      {users.map((user) => (
        <div key={user.id}>
          <label>
            <input
              type="checkbox"
              onChange={(e) => handleUserSelection(user.id, e.target.checked)}
              checked={checkedUsers.includes(user.id)}
            />
            {user.name}
          </label>
        </div>
      ))}
    </div>
  );
};

export default ListaDeUsers;