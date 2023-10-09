<?php

namespace App\View\Components;

use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\Http;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\View\Component;

class Instalaciones extends Component
{
    public $galeriaubicacions;
    /**
     * Create a new component instance.
     */
    public function __construct()
    {
        //
        $response = Http::get('http://127.0.0.1:9090/galeriaubicacion');
        $galeriaubicacions = $response->json();
        $perPage = 80;
        $currentPage = LengthAwarePaginator::resolveCurrentPage();
        $currentItems = array_slice($galeriaubicacions, ($currentPage - 1) * $perPage, $perPage);
        $this->galeriaubicacions = new LengthAwarePaginator($currentItems, count($galeriaubicacions), $perPage);
    }

    /**
     * Get the view / contents that represent the component.
     */
    public function render(): View|Closure|string
    {
        return view('components.instalaciones');
    }
}
