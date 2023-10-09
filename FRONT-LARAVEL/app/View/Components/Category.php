<?php

namespace App\View\Components;

use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Http;
use Illuminate\View\Component;

class Category extends Component
{
    public $categoriablogs;
    /**
     * Create a new component instance.
     */
    public function __construct()
    {
        //
        $response = Http::get('http://127.0.0.1:9090/categoriablog');
        $categoriablogs = $response->json();
        $perPage = 8;
        $currentPage = LengthAwarePaginator::resolveCurrentPage();
        $currentItems = array_slice($categoriablogs, ($currentPage - 1) * $perPage, $perPage);
        $this->categoriablogs = new LengthAwarePaginator($currentItems, count($categoriablogs), $perPage);
    }

    /**
     * Get the view / contents that represent the component.
     */
    public function render(): View|Closure|string
    {
        return view('components.category');
    }
}
