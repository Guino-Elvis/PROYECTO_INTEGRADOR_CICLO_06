<?php

namespace App\View\Components;

use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\Http;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\View\Component;

class Team extends Component
{
    public $docentes;

    /**
     * Create a new component instance.
     */
    public function __construct()
    {
        $response = Http::get('http://127.0.0.1:9090/docente');
        $docentes = $response->json();
        $perPage = 6;
        $currentPage = LengthAwarePaginator::resolveCurrentPage();
        $currentItems = array_slice($docentes, ($currentPage - 1) * $perPage, $perPage);
        $this->docentes = new LengthAwarePaginator($currentItems, count($docentes), $perPage);
    }

    /**
     * Get the view / contents that represent the component.
     */
    public function render(): View|Closure|string
    {
        return view('components.team');
    }
}
