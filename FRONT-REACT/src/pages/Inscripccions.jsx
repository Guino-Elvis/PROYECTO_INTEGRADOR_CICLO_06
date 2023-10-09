import axios from "axios";
import ExcelJS from 'exceljs';
import ListaDeAlumnos from '../components/ListaDeAlumnos';
import LisAlumnooIns from '../components/LisAlumnooIns';
import { useState, useEffect } from "react";
import jsPDF from 'jspdf';
import 'jspdf-autotable';
import alumnoa from '../styles/add.css';
import Modal from "../components/Modal";
import AppLayout from '../components/admin/AppLayout';
import ListaCursoIns from "../components/ListaCursoIns";
const Inscripccions = () => {

  // token
  const token = localStorage.getItem("token");
  // end token

  // paginacion
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage, setItemsPerPage] = useState(1);
  const [searchTerm, setSearchTerm] = useState('');
  const [filteredInscripccions, setFilteredInscripccions] = useState([]);

  const getCurrentItems = () => {
    const startIndex = (currentPage - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;
    return filteredInscripccions.slice(startIndex, endIndex);
  };
  // end paginacion
  // modal
  const [isModalOpen, setIsModalOpen] = useState(false);

  const openModal = () => {
    setIsModalOpen(true);
  };

  const closeModal = () => {
    setIsModalOpen(false);
  };
  // end modal

  const API_URL = "http://localhost:9090";
  const [modalIsOpen, setModalIsOpen] = useState(false);
  const [inscripccions, setInscripccions] = useState([]);
  const [detalle, setDetalle] = useState([]);
  //fracmento de paginacion
  const totalPages = Math.ceil(inscripccions.length / itemsPerPage);
  const hasNextPage = () => {
    return currentPage < totalPages && inscripccions.slice(currentPage * itemsPerPage, (currentPage + 1) * itemsPerPage).length > 0;
  };
  // end fracmento de paginacion


  const [inscripccionEditado, setInscripccionEditado] = useState({
    id: null,
    serie: "",
    numero: "",
    descripcion: "",
    alumnoId: "",
    detalle: [],
  });




  const NombreAlumnoyCurso = ({ cursoId }) => {
    const [nombreCurso, setNombreCurso] = useState('');
    const [fotoCurso, setFotoCurso] = useState('');
    const [costoCurso, setCostoCurso] = useState('');

    useEffect(() => {
      axios
        .get(`${API_URL}/curso/${cursoId}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        })
        .then((response) => {
          const curso = response.data;
          setNombreCurso(curso.nombre);
          setFotoCurso(curso.foto);
          setCostoCurso(curso.costo);
        })
        .catch((error) => {
          console.log(error);
          setNombreCurso('');
          setFotoCurso('');
          setCostoCurso('');
        });
    }, [cursoId]);

    return (
      <>
        <div className="w-28 flex">
          <img
            src={fotoCurso}
            className="inline-flex items-center justify-center mr-4 text-sm text-white transition-all duration-200 ease-in-out h-9 w-9 rounded-xl"
            alt="curso"
          />
                    <div class="flex pl-10 flex-col justify-center">
            <p class="mb-0 text-xs leading-tight dark:text-white dark:opacity-80 text-slate-400">
            <h6 class="mb-0 text-sm leading-normal dark:text-white">S/. {costoCurso}</h6>
            </p>
          </div>
        </div>
        <div class="flex px-2 py-1" key={detalle.id}>
          <div className="w-28">
           <h6 class="mb-0 text-sm leading-normal dark:text-white">{nombreCurso}</h6>
          </div>

        </div>
      </>
    );
  };


  const getInscripccions = () => {
    axios
      .get(`${API_URL}/inscripccion`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((response) => {
        const inscripccions = response.data;

        const sortedInscripccions = inscripccions.sort((a, b) => b.id - a.id);
        setInscripccions(sortedInscripccions);

        const filtered = inscripccions.filter((inscripccion) => {
          const nombreCompleto = `${inscripccion.serie}`;
          return nombreCompleto.toLowerCase().includes(searchTerm.toLowerCase());
        });
        setFilteredInscripccions(filtered);

        // Obtener los nombres de los alumnos para cada inscripccion
        const alumnoPromises = filtered.map((inscripccion) => {
          return axios.get(`${API_URL}/alumno/${inscripccion.alumnoId}`, {
            headers: {
              Authorization: `Bearer ${token}`,
            },
          });
        });


        axios
          .all(alumnoPromises)
          .then((responses) => {
            // Mapear los nombres de los horarios a las inscripccions correspondientes
            const inscripccionsConAlumnos = filtered.map((inscripccion, index) => {
              const nombreAlumno = responses[index].data.nombre;
              return { ...inscripccion, nombreAlumno };
            });

            setFilteredInscripccions(inscripccionsConAlumnos);
          })
          .catch((error) => {
            console.log(error);
          });
      })
      .catch((error) => {
        console.log(error);
      });
  };


  useEffect(() => {
    getInscripccions();
  }, []);





  const exportToExcel = (data) => {
    const workbook = new ExcelJS.Workbook();
    const worksheet = workbook.addWorksheet('Inscripccions');

    // Establecer estilo para las columnas separadas
    worksheet.columns = [
      { width: 3 }, // Columna A
      { width: 20 }, // Columna B
      { width: 15 }, // Columna C
      { width: 25 }, // Columna D
      { width: 15 }, // Columna E
      { width: 30 }, // Columna F
      { width: 80 }, // Columna G
      { width: 20 }, // Columna H

    ];

    // Establecer estilo para los encabezados
    const headerStyle = {
      fill: {
        type: 'pattern',
        pattern: 'solid',
        fgColor: { argb: '000080' }, // Color de fondo negro
      },
      font: {
        color: { argb: 'FFFFFF' }, // Color de texto blanco
        bold: true, // Negrita
      },
    };

    // Añadir los encabezados a la hoja de cálculo con el estilo
    const headers = ['ID', 'Nombre', 'Hora', 'Curso', 'Alumno', 'Estado', 'Creado', 'Actualizado'];
    const headerRow = worksheet.addRow(headers);
    headerRow.eachCell((cell) => {
      cell.fill = headerStyle.fill;
      cell.font = headerStyle.font;
    });

    // Añadir los datos a la hoja de cálculo
    data.forEach((inscripccion, index) => {
      const row = worksheet.addRow(Object.values(inscripccion));
      const isEvenRow = index % 2 === 0;

      // Establecer el estilo de la fila
      const rowStyle = {
        fill: {
          type: 'pattern',
          pattern: 'solid',
          fgColor: { argb: isEvenRow ? 'CCE0FF' : 'DCDCDC' }, // Color celeste(1) o grisclaro(2) intercalado
        },
      };
      row.eachCell((cell) => {
        cell.fill = rowStyle.fill;
      });
    });

    // Guardar el archivo Excel
    workbook.xlsx.writeBuffer().then((buffer) => {
      const blob = new Blob([buffer], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
      const filename = 'inscripccions.xlsx';

      // Descargar el archivo Excel
      if (window.navigator && window.navigator.msSaveOrOpenBlob) {
        // Para Internet Explorer
        window.navigator.msSaveOrOpenBlob(blob, filename);
      } else {
        // Para otros navegadores
        const url = window.URL.createObjectURL(blob);
        const link = document.createElement('a');
        link.href = url;
        link.download = filename;
        link.click();
        window.URL.revokeObjectURL(url);
      }
    });
  };










  const generarPDF = () => {
    const doc = new jsPDF();

    // Crear los encabezados de las columnas
    const headers = ['ID', 'Nombre', 'Hora', 'Curso', 'Alumno', 'Estado', 'Creado', 'Actualizado'];

    // Obtener los datos de los inscripccions en un formato de tabla
    const data = inscripccions.map((inscripccion) => [
      inscripccion.horario,
      inscripccion.cursoId,
      inscripccion.detalle,
      inscripccion.created_at,
      inscripccion.updated_at,
    ]);

    // Establecer los estilos de la tabla
    const tableStyles = {
      startY: 20,
      headStyles: {
        fillColor: '#FFA500', // Naranja claro
        textColor: '#FFFFFF', // Texto blanco
        fontStyle: 'bold', // Texto en negrita
      },
      bodyStyles: {
        textColor: '#444',
      },
      alternateRowStyles: {
        fillColor: '#f5f5f5',
      },
    };

    // Generar la tabla utilizando autoTable
    doc.autoTable({
      head: [headers],
      body: data,
      ...tableStyles,
    });

    // Guardar el PDF
    doc.save('inscripccions.pdf');
  };













  const crearInscripccion = async (event) => {
    event.preventDefault();
    if (
      !inscripccionEditado.serie ||
      !inscripccionEditado.numero ||
      !inscripccionEditado.descripcion ||
      // !inscripccionEditado.curso ||
      !inscripccionEditado.alumnoId ||
      !Array.isArray(inscripccionEditado.detalle) ||
      inscripccionEditado.detalle.length === 0 ||
      inscripccionEditado.detalle.some(
        (detalle) => !detalle.cursoId || detalle.costo === ""
      )
    ) {
      console.log('Error de validación en los datos de la inscripccion');
      console.log('inscripccionEditado:', inscripccionEditado);
      return;
    }

    try {
      // Crear la nueva inscripccion
      const nuevaInscripccion = {
        serie: inscripccionEditado.serie,
        numero: inscripccionEditado.numero,
        descripcion: inscripccionEditado.descripcion,
        alumnoId: inscripccionEditado.alumnoId,
        detalle: inscripccionEditado.detalle.map((detalle) => ({
          cursoId: detalle.cursoId,
          costo: detalle.costo,
        })),
      };

      console.log('Nueva inscripccion:', nuevaInscripccion);

      // Realizar la solicitud POST para crear la inscripccion utilizando axios
      const response = await axios.post(`${API_URL}/inscripccion`, nuevaInscripccion, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      console.log('Respuesta de creación de inscripccion:', response.data);

      setInscripccionEditado({
        id: null,
        serie: "",
        numero: "",
        descripcion: "",
        alumnoId: "",
        detalle: [],
      });

      getInscripccions();
      closeModal()
    } catch (error) {
      console.log('Error al crear la inscripccion:', error);
    }
  };


  const editarInscripccion = (id) => {
    const inscripccion = inscripccions.find((p) => p.id === id);
    setInscripccionEditado({
      id: inscripccion.id,
      serie: inscripccion.serie,
      numero: inscripccion.numero,
      descripcion: inscripccion.descripcion,
      alumnoId: inscripccion.alumnoId,
      detalle: inscripccion.detalle

    });
    openModal()
  }



  const actualizarInscripccion = async (event) => {
    event.preventDefault();

    try {

      const inscripccionActualizado = {
        id: inscripccionEditado.id,
        serie: inscripccionEditado.serie,
        numero: inscripccionEditado.numero,
        descripcion: inscripccionEditado.descripcion,
        alumnoId: inscripccionEditado.alumnoId,
        detalle: inscripccionEditado.detalle.map((detalle) => ({
          cursoId: detalle.cursoId,
          costo: detalle.costo,
        })),
      };


      const response = await axios.put(
        `${API_URL}/inscripccion`,
        inscripccionActualizado,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );


      getInscripccions();
      closeModal()
      setInscripccionEditado({
        id: null,
        serie: "",
        numero: "",
        descripcion: "",
        alumnoId: "",
        detalle: [],
      });
    } catch (error) {
      console.log(error);
    }
  };

  const eliminarInscripccion = (id) => {
    axios
      .delete(`${API_URL}/inscripccion/${id}`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        })
      .then((response) => {
        getInscripccions();
      })
      .catch((error) => {
        console.log(error);
      });
  }


  const contenidoModal = (


    <div className="px-6 py-6 mx-2 mt-2 mb-2 text-left bg-white   shadow-slate-400 shadow-md">
      <div className="flex justify-center">
        <svg xmlns="http://www.w3.org/2000/svg" className="w-20 h-20 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path d="M12 14l9-5-9-5-9 5 9 5z" />
          <path d="M12 14l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z" />
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l9-5-9-5-9 5 9 5zm0 0l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14zm-4 6v-7.5l4-2.222" />
        </svg>
      </div>
      <h2 className="text-2xl font-bold text-center">{inscripccionEditado.id ? 'Editar Inscripccion' : 'Crear Inscripccion'}</h2>
      <form onSubmit={inscripccionEditado.id ? actualizarInscripccion : crearInscripccion}>
        <div className="mt-4">

          <div className="ml-1">
            <label className="block">Serie</label>
            <input
              value={inscripccionEditado.serie}
              onChange={(event) =>
                setInscripccionEditado({
                  ...inscripccionEditado,
                  serie: event.target.value,
                })
              }
              type="text"
              placeholder="serie"
              className="w-full px-4 py-2 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600"
            />
          </div>
          <div className="ml-1">
            <label className="block">Numero</label>
            <input
              value={inscripccionEditado.numero}
              onChange={(event) =>
                setInscripccionEditado({
                  ...inscripccionEditado,
                  numero: event.target.value,
                })
              }
              type="text"
              placeholder="numero"
              className="w-full px-4 py-2 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600"
            />
          </div>
          <div className="ml-1">
            <label className="block">Descripcion</label>
            <input
              value={inscripccionEditado.descripcion}
              onChange={(event) =>
                setInscripccionEditado({
                  ...inscripccionEditado,
                  descripcion: event.target.value,
                })
              }
              type="text"
              placeholder="serie"
              className="w-full px-4 py-2 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600"
            />
          </div>

          <div className="ml-1 pt-2">
            <label className="block">Alumno</label>
            <LisAlumnooIns
              onChange={(alumnoId) =>
                setInscripccionEditado({
                  ...inscripccionEditado,
                  alumnoId: alumnoId, // Actualizar la propiedad horario con un objeto
                })
              }
              selectedAlumnoId={inscripccionEditado.alumnoId} // Pasar el ID del ALUMNO seleccionado
              InscripccionEditado={inscripccionEditado}
              setInscripccionEditado={setInscripccionEditado}
            />
          </div>
          <div className="ml-1 pt-2">
            <label className="block">Curso</label>
            <ListaCursoIns
              onChange={(cursoId, checked) => {
                const updatedDetalle = inscripccionEditado.detalle.map((detalle) => {
                  if (detalle.cursoId === cursoId) {
                    return { ...detalle };
                  }
                  return detalle;
                });
                if (!updatedDetalle.some((detalle) => detalle.cursoId === cursoId)) {
                  updatedDetalle.push({ cursoId: cursoId });
                }
                setInscripccionEditado({ ...inscripccionEditado, detalle: updatedDetalle });
              }}
              selectedCursoId={inscripccionEditado.detalle.map((detalle) => detalle.cursoId)}
              InscripccionEditado={inscripccionEditado}
              setInscripccionEditado={setInscripccionEditado}
            />
          </div>

          <div className="flex  flex-shrink-0 flex-wrap items-center justify-end rounded-b-md border-t-2 border-neutral-100 border-opacity-100 p-4 dark:border-opacity-50">
            <button
              type="button"
              onClick={closeModal}
              className="ml-1 text-red-800  font-bold inline-block rounded bg-primary px-6 pb-2 pt-2.5 text-xs uppercase leading-normal shadow-[0_4px_9px_-4px_#3b71ca] transition duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]"
            >
              Close
            </button>

            <div
              type="button"
              className="ml-1 text-blue-700 font-bold inline-block rounded bg-primary px-6 pb-2 pt-2.5 text-xs uppercase leading-normal shadow-[0_4px_9px_-4px_#3b71ca] transition duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]"
            >
              {inscripccionEditado.id ? (
                <button onClick={actualizarInscripccion} >Actualizar</button>
              ) : (
                <button onClick={crearInscripccion} >Crear </button>
              )}
            </div>
          </div>
        </div>
      </form>
    </div>
  );

  const currentItems = getCurrentItems();
  return (

    <AppLayout>
      <div className="">
        <Modal className="w-1/3 mx-auto" isOpen={isModalOpen} onRequestClose={closeModal}>
          {contenidoModal}
        </Modal>

        <div class="flex flex-wrap -mx-3">
          <div class="flex-none w-full max-w-full px-3">
            <div class=" flex flex-col min-w-0 mb-6 break-words bg-white border-0 border-transparent border-solid shadow-xl dark:bg-slate-850 dark:shadow-dark-xl rounded-2xl bg-clip-border">
              <div class="p-6 pb-0 mb-0 border-b-0 border-b-solid rounded-t-2xl border-b-transparent">
                <h6 class="dark:text-white font-bold">Lista De Inscripccions</h6>
              </div>
              <div class="flex-auto px-0 pt-0 pb-2">
                <div class="p-0 overflow-x-auto ps">

                  <nav class=" flex flex-wrap items-center justify-between px-0 py-2 mx-6 transition-all shadow-none duration-250 ease-soft-in rounded-2xl lg:flex-nowrap lg:justify-start" >
                    <div class="flex  items-center justify-between w-full px-4 py-1 mx-auto flex-wrap-inherit ">
                      <nav className=" flex ">
                        <div class="mb-0 font-bold capitalize m-2 ">
                          <button onClick={generarPDF} className="text-red-700 w-10"  >
                            <div className="hidden">pdf</div>
                            <svg role="img" viewBox="0 0 24 24" fill="red" xmlns="http://www.w3.org/2000/svg"><path d="M23.63 15.3c-.71-.745-2.166-1.17-4.224-1.17-1.1 0-2.377.106-3.761.354a19.443 19.443 0 0 1-2.307-2.661c-.532-.71-.994-1.49-1.42-2.236.817-2.484 1.207-4.507 1.207-5.962 0-1.632-.603-3.336-2.342-3.336-.532 0-1.065.32-1.349.781-.78 1.384-.425 4.4.923 7.381a60.277 60.277 0 0 1-1.703 4.507c-.568 1.349-1.207 2.733-1.917 4.01C2.834 18.53.314 20.34.03 21.758c-.106.533.071 1.03.462 1.42.142.107.639.533 1.49.533 2.59 0 5.323-4.188 6.707-6.707 1.065-.355 2.13-.71 3.194-.994a34.963 34.963 0 0 1 3.407-.745c2.732 2.448 5.145 2.839 6.352 2.839 1.49 0 2.023-.604 2.2-1.1.32-.64.106-1.349-.213-1.704zm-1.42 1.03c-.107.532-.64.887-1.384.887-.213 0-.39-.036-.604-.071-1.348-.32-2.626-.994-3.903-2.059a17.717 17.717 0 0 1 2.98-.248c.746 0 1.385.035 1.81.142.497.106 1.278.426 1.1 1.348zm-7.524-1.668a38.01 38.01 0 0 0-2.945.674 39.68 39.68 0 0 0-2.52.745 40.05 40.05 0 0 0 1.207-2.555c.426-.994.78-2.023 1.136-2.981.354.603.745 1.207 1.135 1.739a50.127 50.127 0 0 0 1.987 2.378zM10.038 1.46a.768.768 0 0 1 .674-.425c.745 0 .887.851.887 1.526 0 1.135-.355 2.874-.958 4.861-1.03-2.768-1.1-5.074-.603-5.962zM6.134 17.997c-1.81 2.981-3.549 4.826-4.613 4.826a.872.872 0 0 1-.532-.177c-.213-.213-.32-.461-.249-.745.213-1.065 2.271-2.555 5.394-3.904Z" /></svg>
                          </button>

                        </div>

                        <div class="mb-0 font-bold capitalize  m-2 ">
                          <button className="w-10" onClick={() => exportToExcel(inscripccions)} >
                            <div className="hidden">exel</div>
                            <svg role="img" viewBox="0 0 24 24" fill="#217346" xmlns="http://www.w3.org/2000/svg"><title>Microsoft Excel</title><path d="M23 1.5q.41 0 .7.3.3.29.3.7v19q0 .41-.3.7-.29.3-.7.3H7q-.41 0-.7-.3-.3-.29-.3-.7V18H1q-.41 0-.7-.3-.3-.29-.3-.7V7q0-.41.3-.7Q.58 6 1 6h5V2.5q0-.41.3-.7.29-.3.7-.3zM6 13.28l1.42 2.66h2.14l-2.38-3.87 2.34-3.8H7.46l-1.3 2.4-.05.08-.04.09-.64-1.28-.66-1.29H2.59l2.27 3.82-2.48 3.85h2.16zM14.25 21v-3H7.5v3zm0-4.5v-3.75H12v3.75zm0-5.25V7.5H12v3.75zm0-5.25V3H7.5v3zm8.25 15v-3h-6.75v3zm0-4.5v-3.75h-6.75v3.75zm0-5.25V7.5h-6.75v3.75zm0-5.25V3h-6.75v3Z" /></svg>
                          </button>
                        </div>
                        <div class="mb-0 font-bold capitalize m-2">
                          {/* <button className="" onClick={() => setModalIsOpen(true)} >
                          <div className=" text-white h-10 rounded-md hover:bg-orange-500 duration-300  p-2 text-center bg-orange-700">Agregar</div>
                        </button> */}
                          <button type="button" className="" onClick={openModal}>
                            <div className="text-white h-10 rounded-md hover:bg-orange-500 duration-300 p-2 text-center bg-orange-700">Agregar</div>
                          </button>
                        </div>
                      </nav>
                      <div class="flex   items-center mt-2 grow sm:mt-0 sm:mr-16 md:mr-0 lg:flex  lg:basis-auto">
                        <div class="flex items-center md:ml-auto md:pr-4">
                          <div class="relative flex flex-wrap items-stretch w-full transition-all rounded-lg ease-soft">
                            <span class="text-sm ease-soft absolute leading-5.6  z-50 -ml-px flex h-full items-center whitespace-nowrap rounded-lg rounded-tr-none rounded-br-none border border-r-0 border-transparent bg-transparent py-2 px-2.5 text-center font-normal text-slate-500 transition-all">
                              <button onClick={getInscripccions} >
                                <svg
                                  xmlns="http://www.w3.org/2000/svg"
                                  viewBox="0 0 20 20"
                                  fill="currentColor"
                                  class="h-4 w-4 ">
                                  <path
                                    fill-rule="evenodd"
                                    d="M9 3.5a5.5 5.5 0 100 11 5.5 5.5 0 000-11zM2 9a7 7 0 1112.452 4.391l3.328 3.329a.75.75 0 11-1.06 1.06l-3.329-3.328A7 7 0 012 9z"
                                    clip-rule="evenodd" />
                                </svg>
                              </button>
                            </span>
                            <input
                              className="p-8  text-sm focus:shadow-soft-primary-outline ease-soft w-1/100 leading-5.6 relative -ml-px block min-w-0 flex-auto rounded-lg border border-solid border-gray-300 bg-white bg-clip-padding py-2 pr-3 text-gray-700 transition-all placeholder:text-gray-500 focus:border-fuchsia-300 focus:outline-none focus:transition-shadow"
                              type="text"
                              id="searchInput"
                              value={searchTerm}
                              onChange={(event) => setSearchTerm(event.target.value)}
                              placeholder="Buscar"
                            />
                          </div>
                        </div>
                      </div>
                    </div>
                  </nav>
                  <table class="items-center w-full mb-0 align-top border-collapse dark:border-white/40 text-slate-500">
                    <thead class="align-bottom">
                      <tr>
                        <th class="px-6 py-3 font-bold text-left uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 ">ID</th>
                        <th class="px-6 py-3 font-bold text-left uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 ">serie</th>
                        <th class="px-6 py-3 font-bold text-left uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 ">Numero</th>
                        <th class="px-6 py-3 pl-2 font-bold text-left uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 ">Descripccion</th>
                        <th class="px-6 py-3 pl-2 font-bold text-left uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 ">Alumno</th>
                        <th class="px-6 py-3 pl-2 font-bold text-left uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 ">curso |  costo</th>
                        <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 ">Creado</th>
                        <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 ">Actualizado</th>
                        <th class="px-6 py-3 font-semibold capitalize align-middle bg-transparent border-b border-collapse border-solid shadow-none dark:border-white/40 dark:text-white tracking-none whitespace-nowrap text-slate-400 opacity-70"></th>
                      </tr>
                    </thead>
                    <tbody>
                      {currentItems.map((inscripccion) => (
                        <tr key={inscripccion.id}>
                          <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 whitespace-nowrap shadow-transparent">
                            <div class="flex px-2 py-1">
                              <div class="flex flex-col justify-center">
                                <span className="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-indigo-500 text-white">
                                  {inscripccion.id}
                                </span>
                              </div>
                            </div>
                          </td>
                          <td class="pl-4 align-middle bg-transparent border-b dark:border-white/40 whitespace-nowrap shadow-transparent">
                            <div class="flex px-2 py-1">
                              <div class="flex flex-col justify-center">
                                <span className=" inline-flex text-md leading-5 font-semibold   text-slate-400">
                                  {inscripccion.serie}
                                </span>
                              </div>
                            </div>
                          </td>
                          <td class="pl-4 align-middle bg-transparent border-b dark:border-white/40 whitespace-nowrap shadow-transparent">
                            <div class="flex px-2 py-1">
                              <div class="flex flex-col justify-center">
                                <span className=" inline-flex text-md leading-5 font-semibold   text-slate-400">
                                  {inscripccion.numero}
                                </span>
                              </div>
                            </div>
                          </td>
                          <td class=" align-middle bg-transparent border-b dark:border-white/40 whitespace-nowrap shadow-transparent">
                            <div class="flex px-2 py-1">
                              <div class="flex flex-col justify-center">
                                <span className=" inline-flex text-md leading-5 font-semibold   text-slate-400">
                                  {inscripccion.descripcion}
                                </span>
                              </div>
                            </div>
                          </td>
                          <td class=" align-middle bg-transparent border-b dark:border-white/40 whitespace-nowrap shadow-transparent">
                            <div class="flex px-2 py-1">
                              <div class="flex flex-col justify-center">
                                <span className=" inline-flex text-md leading-5 font-semibold   text-slate-400">
                                  {inscripccion.nombreAlumno}
                                </span>
                              </div>
                            </div>
                          </td>

                          <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 whitespace-nowrap shadow-transparent">
                            {inscripccion.detalle.map((detalle) => (
                              <div class="flex px-2 py-1" key={detalle.id}>
                                <div className="w-28">
                                  <NombreAlumnoyCurso cursoId={detalle.cursoId} />
                                </div>
                                <div class="flex pl-10 flex-col justify-center">
                                  <p class="mb-0 text-xs leading-tight dark:text-white dark:opacity-80 text-slate-400">
                                    {/* <span className={detalle.status === 0 ? 'bg-red-600 rounded p-1 text-white' : 'bg-green-500 rounded p-1 text-white'}>
                                      {detalle.status === 0 ? 'FALTO' : 'ASISTIO'}
                                    </span> */}
                                  </p>
                                </div>
                              </div>
                            ))}
                          </td>

                          <td class="p-2 text-center align-middle bg-transparent border-b dark:border-white/40 whitespace-nowrap shadow-transparent">
                            <span class="text-xs font-semibold leading-tight dark:text-white dark:opacity-80 text-slate-400">{inscripccion.created_at}</span>
                          </td>
                          <td class="p-2 text-center align-middle bg-transparent border-b dark:border-white/40 whitespace-nowrap shadow-transparent">
                            <span class="text-xs font-semibold leading-tight dark:text-white dark:opacity-80 text-slate-400">{inscripccion.updated_at}</span>
                          </td>
                          <td class=" sticky right-0 p-2 align-middle bg-transparent border-b dark:border-white/40 whitespace-nowrap shadow-transparent">
                            {/* <div class="ml-auto text-right"> */}
                            <div className=" m-1 btns inline-block px-4 py-3 mb-0 font-bold text-center uppercase align-middle transition-all bg-transparent border-0 rounded-lg shadow-none cursor-pointer leading-pro text-xs ease-soft-in bg-150 hover:scale-102 active:opacity-85 bg-x-25">
                              <button onClick={() => eliminarInscripccion(inscripccion.id)} >
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6 text-red-400 ">
                                  <path stroke-linecap="round" stroke-linejoin="round" d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0" />
                                </svg>
                              </button>
                            </div>
                            <a class="btns inline-block px-4 py-3 mb-0 font-bold text-center uppercase align-middle transition-all bg-transparent border-0 rounded-lg shadow-none cursor-pointer leading-pro text-xs ease-soft-in bg-150 hover:scale-102 active:opacity-85 bg-x-25 ">
                              <button onClick={() => editarInscripccion(inscripccion.id)} >
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6 text-slate-400">
                                  <path stroke-linecap="round" stroke-linejoin="round" d="M16.862 4.487l1.687-1.688a1.875 1.875 0 112.652 2.652L6.832 19.82a4.5 4.5 0 01-1.897 1.13l-2.685.8.8-2.685a4.5 4.5 0 011.13-1.897L16.863 4.487zm0 0L19.5 7.125" />
                                </svg>
                              </button>
                            </a>
                            {/* </div> */}
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                  {/* paginacion */}
                  <div className="  left-0 flex mt-4 text-blue-700 font-bold  rounded bg-primary px-6 pb-2 pt-2.5 text-xs uppercase leading-normal shadow-[0_4px_9px_-4px_#3b71ca] transition duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]">
                    <div className="">
                      <button
                        onClick={() => setCurrentPage(currentPage - 1)}
                        disabled={currentPage === 1}
                        className="text-green-500 font-bold inline-block rounded bg-primary  px-6 pb-2 pt-2.5 text-xs uppercase leading-normal shadow-[0_4px_9px_-4px_#3b71ca] transition duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]"

                      ><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                          <path stroke-linecap="round" stroke-linejoin="round" d="M11.25 9l-3 3m0 0l3 3m-3-3h7.5M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                        Anterior</button>
                      <span className=" p-2 font-semibold  text-blue-700  inline-block rounded bg-primary px-6 pb-2 pt-2.5 text-xs uppercase leading-normal shadow-[0_4px_9px_-4px_#3b71ca] transition duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]">{` ${currentPage} DE ${totalPages}`}</span>
                      <button
                        onClick={() => setCurrentPage(currentPage + 1)}
                        disabled={currentItems.length < itemsPerPage || !hasNextPage()}
                        className="text-blue-700 font-bold inline-block rounded bg-primary px-6 pb-2 pt-2.5 text-xs uppercase leading-normal shadow-[0_4px_9px_-4px_#3b71ca] transition duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]"

                      ><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                          <path stroke-linecap="round" stroke-linejoin="round" d="M12.75 15l3-3m0 0l-3-3m3 3h-7.5M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                        Siguiente</button>
                    </div>
                    <div>


                    </div>
                    <select
                      className="text-orange-600 ml-2 font-bold inline-block rounded bg-primary px-6 pb-2 pt-2.5 text-xs uppercase leading-normal shadow-[0_4px_9px_-4px_#3b71ca] transition duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]"
                      value={itemsPerPage}
                      onChange={(e) => setItemsPerPage(parseInt(e.target.value))}
                    >
                      <option className="as font-semibold " value={1}>  1 col</option>
                      <option className="as font-semibold " value={5}>  5 col</option>
                      <option className="as font-semibold" value={10}> 10 col</option>
                      <option className="as font-semibold" value={50}> 50 col</option>
                      <option className="as font-semibold" value={100}>100 col</option>
                      <option className="as font-semibold" value={500}>500 col</option>
                    </select>

                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </AppLayout>
  );
}

export default Inscripccions;

