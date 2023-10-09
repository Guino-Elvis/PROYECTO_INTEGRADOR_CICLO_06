import React, { useState, useEffect } from 'react';
import { PDFDownloadLink, Document, Page, StyleSheet, Text, View } from '@react-pdf/renderer';
import axios from 'axios';
import jsPDF from 'jspdf';

const styles = StyleSheet.create({
  page: {
    fontFamily: 'Helvetica',
    paddingTop: 35,
    paddingBottom: 65,
    paddingHorizontal: 35,
  },
  section: {
    margin: 10,
    padding: 10,
    flexGrow: 1,
  },
  table: {
    display: 'table',
    width: '100%',
    borderStyle: 'solid',
    borderWidth: 1,
    borderRightWidth: 0,
    borderBottomWidth: 0,
  },
  tableRow: {
    margin: 'auto',
    flexDirection: 'row',
  },
  tableCellHeader: {
    margin: 5,
    fontSize: 12,
    fontWeight: 'bold',
    borderBottomColor: '#000',
    borderBottomWidth: 1,
  },
  tableCell: {
    margin: 5,
    fontSize: 10,
  },
});

const MyDocument = ({ data }) => (
  <Document>
    <Page style={styles.page}>
      <View style={styles.section}>
        <View style={styles.table}>
          <View style={styles.tableRow}>
            <Text style={styles.tableCellHeader}>Código</Text>
            <Text style={styles.tableCellHeader}>Nombre</Text>
            <Text style={styles.tableCellHeader}>Apellido</Text>
            <Text style={styles.tableCellHeader}>DNI</Text>
            <Text style={styles.tableCellHeader}>Correo</Text>
          </View>
          {data.map((alumno) => (
            <View style={styles.tableRow} key={alumno.id}>
              <Text style={styles.tableCell}>{alumno.codigo}</Text>
              <Text style={styles.tableCell}>{alumno.nombre}</Text>
              <Text style={styles.tableCell}>{alumno.apellido}</Text>
              <Text style={styles.tableCell}>{alumno.dni}</Text>
              <Text style={styles.tableCell}>{alumno.correo}</Text>
            </View>
          ))}
        </View>
      </View>
    </Page>
  </Document>
);

const PDFButton = () => {
  const [data, setData] = useState([]);

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      const response = await axios.get('/alumno');
      setData(response.data);
    } catch (error) {
      console.error('Error fetching data:', error);
    }
  };

  const generatePDF = () => {
    const doc = new jsPDF();
    doc.setFontSize(12);
    doc.text('Alumnos', 10, 10);
    doc.autoTable({
      head: [['Código', 'Nombre', 'Apellido', 'DNI', 'Correo']],
      body: data.map((alumno) => [
        alumno.codigo,
        alumno.nombre,
        alumno.apellido,
        alumno.dni,
        alumno.correo,
      ]),
      startY: 20,
    });
    doc.save('alumnos.pdf');
  };

  return (
    <div>
      <button onClick={generatePDF}>Generar PDF</button>
    </div>
  );
};

export default PDFButton;