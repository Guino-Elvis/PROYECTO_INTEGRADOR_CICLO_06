import React from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
// import Header from "./components/Header";
import Cursos from "./pages/Cursos";
import Docentes from "./pages/Docentes";
import Inscripccions from "./pages/Inscripccions";
import Alumnocrud from "./pages/Alumnocrud";
import Asistencias from "./pages/Asistencias";
import Horarios from "./pages/Horarios";
import Sliders from "./pages/Sliders";
import CategoriaBlogs from "./pages/CategoriaBlogs";
import Abouts from "./pages/Abouts";
import Blogs from "./pages/Blogs";
import Dashboard from "./pages/Dashboard";
import Virtualbox from "./pages/Vvirtualbox";
import Login from "./pages/auth/Loogin";
import GaleriaActividads from "./pages/GaleriaActividads";
import GaleriaUbicacions from "./pages/GaleriaUbicacions";
import Videos from "./pages/Videos";
const App = () => {
  return (
    <Router>
      {/* <Header /> */}
      <div className="">
        <Routes>
          <Route path="/horarios" element={<Horarios />} />
          <Route path="/alumno" element={<Alumnocrud />} />
          <Route path="/docentes" element={<Docentes />} />
          <Route path="/cursos" element={<Cursos />} />
          <Route path="/inscripccion" element={<Inscripccions />} />
          <Route path="/asistencia" element={<Asistencias />} />
          <Route path="/slider" element={<Sliders />} />
          <Route path="/video" element={<Videos />} />
          <Route path="/actividad" element={<GaleriaActividads />} />
          <Route path="/ubicacion" element={<GaleriaUbicacions />} />
          <Route path="/slider" element={<Sliders />} />
          <Route path="/slider" element={<Sliders />} />
          <Route path="/categoriablog" element={<CategoriaBlogs />} />
          <Route path="/about" element={<Abouts />} />
          <Route path="/blog" element={<Blogs />} />
          <Route path="/dashboard" element={<Virtualbox/>} />

          {/* admin */}
          {/* <Route path="/" element={<Dashboard />} /> */}

          {/* login */}
          <Route path="/" element={<Login />} />
        </Routes>
      </div>
    </Router>
  );
};

export default App;