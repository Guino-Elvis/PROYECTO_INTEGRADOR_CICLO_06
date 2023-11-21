import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { API_URL } from '../config';
function LisUserIns({ onChange }) {
  const [users, setUsers] = useState([]);
  const [selectedUserId, setSelectedUserId] = useState('');
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
  const handleSeleccionarUser = (event) => {
    const userId = event.target.value;
    setSelectedUserId(userId);
    onChange(userId);
  };

  return (
    <select value={selectedUserId} onChange={handleSeleccionarUser}>
      {users.map((user) => (
        <option key={user.id} value={user.id}>
          {user.name} 
        </option>
      ))}
    </select>
  );
}

export default LisUserIns;