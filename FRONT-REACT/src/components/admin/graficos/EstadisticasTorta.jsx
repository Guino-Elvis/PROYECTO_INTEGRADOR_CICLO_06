import React, { Component } from 'react';
import { Cell, Pie, PieChart, ResponsiveContainer, Tooltip } from 'recharts';

const data01 = [
    { name: "Grupo A", value: 2300 },
    { name: "Grupo B", value: 1500 },
    { name: "Grupo C", value: 3200 },
    { name: "Grupo D", value: 1800 },
    { name: "Grupo E", value: 2700 },
];

const data02 = [

    { name: "Grupo A", value: 2300 },
    { name: "Grupo B", value: 1500 },
    { name: "Grupo C", value: 3200 },
    { name: "Grupo D", value: 1800 },
    { name: "Grupo E", value: 2700 },
];

const data03 = [

    { name: "Grupo A", value: 2300 },
    { name: "Grupo B", value: 1500 },
    { name: "Grupo C", value: 3200 },
    { name: "Grupo D", value: 1800 },
    { name: "Grupo E", value: 2700 },
];

const data04 = [

    { name: "Grupo A", value: 2300 },
    { name: "Grupo B", value: 1500 },
    { name: "Grupo C", value: 3200 },
    { name: "Grupo D", value: 1800 },
    { name: "Grupo E", value: 2700 },
];

const data05 = [

    { name: "Grupo A", value: 2300 },
    { name: "Grupo B", value: 1500 },
    { name: "Grupo C", value: 3200 },
    { name: "Grupo D", value: 1800 },
    { name: "Grupo E", value: 2700 },
];

const generateRandomColor = () => {
    const characters = '0123456789ABCDEF';
    let color = '#';
    for (let j = 0; j < 6; j++) {
      color += characters[Math.floor(Math.random() * 16)];
    }
    return color;
  };
  
  const colors1 = Array.from({ length: 5 }, () => generateRandomColor());
  const colors2 = Array.from({ length: 5 }, () => generateRandomColor());
  const colors3 = Array.from({ length: 5 }, () => generateRandomColor());
  const colors4 = Array.from({ length: 5 }, () => generateRandomColor());
  const colors5 = Array.from({ length: 5 }, () => generateRandomColor());


class EstadisticasTorta extends Component {
    render() {
        return (
            <div style={{ maxWidth: '500', height: 400 }}>
                  <h1 className='pl-10 font-bold'>Alumnos Por Curso</h1>
                <ResponsiveContainer>
                    <PieChart>
                        <Pie data={data01} dataKey="value" nameKey="name" innerRadius={60} outerRadius={85} fill='#ffaa33'>
                            {data01.map((entry, index) => (
                                <Cell key={`cell-${index}`} fill={colors1[index % colors1.length]} />
                            ))}
                        </Pie>
                        <Pie data={data02} dataKey="value" nameKey="name" innerRadius={90} outerRadius={115}  >
                        {data02.map((entry, index) => (
                                <Cell key={`cell-${index}`} fill={colors2[index % colors2.length]} />
                            ))}
                        </Pie>
                        <Pie data={data03} dataKey="value" nameKey="name" innerRadius={120} outerRadius={145}  >
                        {data03.map((entry, index) => (
                                <Cell key={`cell-${index}`} fill={colors3[index % colors3.length]} />
                            ))}
                        </Pie>
                        {/* <Pie data={data04} dataKey="value" nameKey="name" innerRadius={150} outerRadius={175}  >
                        {data04.map((entry, index) => (
                                <Cell key={`cell-${index}`} fill={colors4[index % colors4.length]} />
                            ))}
                        </Pie>
                        <Pie data={data05} dataKey="value" nameKey="name" innerRadius={180} outerRadius={205}  >
                        {data05.map((entry, index) => (
                                <Cell key={`cell-${index}`} fill={colors5[index % colors5.length]} />
                            ))}
                        </Pie> */}
                        <Tooltip />
                    </PieChart>
                </ResponsiveContainer>
            </div>
        );
    }
}

export default EstadisticasTorta