<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use GuzzleHttp\Client;
use App\Models\Alumno;
use App\Models\Piscinas;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Storage;

class AlumnosController extends Controller
{
    public function index(Request $Request)
    {
        $busqueda = $Request->busqueda;
        $url = env('URL_SERVER_API', 'http://127.0.0.1');
        // Se realiza una consulta a la API para obtener los datos de los alumnos.
        $response = Http::get($url.'/alumnos');
        $data = collect($response->json())->map(function ($item) {
            return (object) $item;
        });
        // Se envían los resultados a la vista.
        return view('alumnos.index', compact('data'));
    }

    public function create()
    {

        return view('alumnos.create');

    }
    public function store(Request $request){
        $url = env('URL_SERVER_API', 'http://127.0.0.1');

        $response = Http::post($url. '/alumnos',[
            'nombre' => $request->nombre,
            'apellido' => $request->apellido,
            'telefono' => $request->telefono,
            'direccion' => $request->direccion,
            'tdocumento' => $request->tdocumento,
            'documento' => $request->documento,
            'codigo' => $request->codigo,
            'status' => $request->status,

        ]);

    if ($response->successful()) {
        return redirect('alumnos')->with('success', 'Alumno agregado con éxito.');
    } else {
        return redirect('alumnos')->with('error', 'Error al agregar el alumno.');
    }
    }

     public function edit($id)
{
    $url = env('URL_SERVER_API', 'http://127.0.0.1');
    $response = Http::get($url.'/alumnos');
    $data = collect($response->json())->map(function ($item) {
        return (object) $item;
    });
    $alumno = $data->first(function ($item) use ($id) {
        return $item->id == $id;
    });

    return view('alumnos.edit', compact('alumno'));
}

    public function update(Request $request, $id)
{
    $url = env('URL_SERVER_API', 'http://127.0.0.1');
    $response = Http::patch($url.'/alumnos/'.$request->$id, [
        'nombre' => $request->nombre,
        'apellido' => $request->apellido,
        'telefono' => $request->telefono,
        'direccion' => $request->direccion,
        'tdocumento' => $request->tdocumento,
        'documento' => $request->documento,
        'codigo' => $request->codigo,
        'status' => $request->status,
    ]);

    if ($response->successful()) {
        return redirect('alumnos')->with('success', 'Alumno actualizado con éxito.');
    } else {
        return redirect('alumnos')->with('error', 'Error al actualizar el alumno.');
    }
}

    public function destroy($idAlumno){
        $url = env('URL_SERVER_API', 'http://127.0.0.1');
        $response = Http::delete($url.'/alumnos/'.$idAlumno);
        if ($response->successful()) {
            return redirect('alumnos')->with('Mensaje', 'Alumno eliminado con éxito.');
        } else {
            return redirect('alumnos')->with('error', 'Error al eliminar el alumno.');
        }
    }

}
