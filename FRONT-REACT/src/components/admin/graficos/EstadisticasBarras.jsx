import React from 'react';
import { Bar, BarChart, CartesianGrid, Legend, ResponsiveContainer, Tooltip, XAxis, YAxis } from 'recharts';

const datosja = [

    { name: "maria", age: 10, weight: 60 },
    { name: "Juan", age: 25, weight: 70 },
    { name: "Ana", age: 32, weight: 58 },
    { name: "Pedro", age: 45, weight: 80 },
    { name: "Sofía", age: 19, weight: 52 },
    { name: "Luis", age: 37, weight: 185 },
    { name: "Carla", age: 28, weight: 63 },
    { name: "Miguel", age: 42, weight: 72 },
    { name: "Laura", age: 31, weight: 68 },
    { name: "Diego", age: 22, weight: 75 },
    { name: "Isabela", age: 29, weight: 55 },
    { name: "Javier", age: 39, weight: 79 },
    { name: "Gabriela", age: 27, weight: 61 },
    { name: "Andrés", age: 36, weight: 74 },
    { name: "Valentina", age: 23, weight: 57 },
    { name: "Ricardo", age: 33, weight: 76 },
]

const EstadisticasBarras = () => {
    return (
        // <div style={{ maxWidth: "500px", height: "300px" }}>
             <div >
            <ResponsiveContainer width={"100%"} aspect={2}>
                <BarChart data={datosja} width={500} height={300}
                    margin={
                        {
                            top: 10,
                            right: 40,
                            left: 10,
                            bottom: 5,
                        }
                    }>
                        {/* definicion de cuadrillas  */}
                    {/* <CartesianGrid strokeDasharray="4 4 4" /> */}
                    <CartesianGrid strokeDasharray="3 3" vertical={false} />
                    {/* definiendo ejes "x = XAxis  , y" =YAxis */}
                    <XAxis dataKey="name" />
                    <YAxis />
                    <Tooltip />
                    <Legend />
                    <Bar dataKey="age" fill="#FF5252" barRadius={40} />
                    <Bar dataKey="weight" fill="#E0E0E0" barRadius={10}  />
                </BarChart>
            </ResponsiveContainer>
        </div>
    );
};

export default EstadisticasBarras;