<?php


use App\Mail\EnviarCorreo;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

// Route::get('/', function () {
//    return view('welcome');
// });

Route::get('/', function () {return view('home.index');})->name('index');
Route::get('/acercade', function () {return view('home.acerca-de');});
Route::get('/cursos', function () {return view('home.cursos');});
Route::get('/profesores', function () {return view('home.profesores');});
Route::get('/contacto', function () {return view('home.contacto');});

Route::get('/blogdetalle', function () {return view('home.blogdetalle');});
Route::get('/bloggrid', function () {return view('home.bloggrid');});


Route::get('/redireccionar-a-react', function () {
    $url = 'http://localhost:3000'; // La URL de la ruta principal de React
    return redirect()->away($url);
})->name('redireccionar-a-react');


// //email

Route::post('enviar-correo', function () {
    $successMessage = "Correo Enviado Exitosamente";

    // Envía el correo electrónico solo si la solicitud se procesó correctamente
    Mail::to(request()->destinatario)
        ->cc('ginoyujra38@gmail.com')
        ->send(new EnviarCorreo(request()->mensaje, request()->adjunto, request()->nombre, request()->asunto));
        session()->flash('success', $successMessage); // Almacena el mensaje de éxito en la variable de sesión

    return response()->json(['message' => $successMessage]);
})->name('enviar-correo');


// Route::get('/', function () {
//     $response = Http::get('http://127.0.0.1:9090/slider');
//     $data = $response->json();

//     foreach ($data as $slider) {
//         echo $slider['titulo'];
//         echo '<br>';
//         echo '<img src="' . $slider['foto'] . '" alt="Foto del slider">';
//         echo '<br><br>';
//     }
// });


// //   //grupos


