import React from 'react';
import { Area, AreaChart, CartesianGrid, ResponsiveContainer, Tooltip, XAxis, YAxis } from 'recharts';

const data = [

    { name: "maria", age: 10, weight: 60 },
    { name: "Sofía", age: 19, weight: 52 },
    { name: "Juan", age: 25, weight: 70 },
    { name: "Ana", age: 32, weight: 58 },
    { name: "Laura", age: 31, weight: 68 },
    { name: "Diego", age: 22, weight: 75 },
    { name: "Gabriela", age: 27, weight: 61 },
    { name: "Carla", age: 28, weight: 63 },
    { name: "Isabela", age: 29, weight: 55 },
    { name: "Valentina", age: 23, weight: 57 },
    { name: "Miguel", age: 42, weight: 72 },
    { name: "Ricardo", age: 33, weight: 76 },
    { name: "Javier", age: 39, weight: 79 },
    { name: "Andrés", age: 36, weight: 74 },
    { name: "Pedro", age: 45, weight: 80 },
    { name: "Luis", age: 37, weight: 185 },
];


const EstadisticasArea = () => {

    return (
        <div className='' >
            {/* <div >  */}
            <ResponsiveContainer width={"100%"} aspect={2}>
                <AreaChart width={730} height={250} data={data}
                    margin={{ top: 10, right: 30, left: 0, bottom: 0 }}>
                    <defs>
                        <linearGradient id="colorUv" x1="0" y1="0" x2="0" y2="1">
                            <stop offset="5%" stopColor="#8884d8" stopOpacity={0.8} />
                            <stop offset="95%" stopColor="#8884d8" stopOpacity={0} />
                        </linearGradient>
                        <linearGradient id="colorPv" x1="0" y1="0" x2="0" y2="1">
                            <stop offset="5%" stopColor="#82ca9d" stopOpacity={0.8} />
                            <stop offset="95%" stopColor="#82ca9d" stopOpacity={0} />
                        </linearGradient>
                    </defs>
                    <XAxis dataKey="name" />
                    <YAxis />
                    <CartesianGrid strokeDasharray="3 3" />
                    <Tooltip />
                    <Area type="monotone" dataKey="age" stroke="#8884d8" fillOpacity={1} fill="url(#colorUv)" />
                    <Area type="monotone" dataKey="weight" stroke="#82ca9d" fillOpacity={1} fill="url(#colorPv)" />
                </AreaChart>
            </ResponsiveContainer>
        </div>
    );
};

export default EstadisticasArea;