import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { API_URL } from '../config';

function ListaDeUsers({ onChange, selectedUserId }) {
  const [users, setUsers] = useState([]);
  // token
  const token = localStorage.getItem("token");
  // end token
  useEffect(() => {
    obtenerUsers();
  }, []);

  const obtenerUsers = () => {
    axios
      .get(`${API_URL}/auth/list`,{
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((response) => {
        setUsers(response.data);
      })
      .catch((error) => {
        console.log(error);
      });
  };

  const handleUserSelection = (userId, checked) => {
    onChange(userId, checked);
  };

  return (
    <div>
      {users.map((user) => (
        <div key={user.id}>
          <label>
            <input
              type="checkbox"
              onChange={(e) => handleUserSelection(user.id, e.target.checked)}
              checked={selectedUserId.includes(user.id)}
            />
            {user.name}
          </label>
        </div>
      ))}
    </div>
  );
}

export default ListaDeUsers;