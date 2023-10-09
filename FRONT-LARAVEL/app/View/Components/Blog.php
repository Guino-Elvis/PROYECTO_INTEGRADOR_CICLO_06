<?php

namespace App\View\Components;

use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Http;
use Illuminate\View\Component;

class Blog extends Component
{
    public $blogs;
    /**
     * Create a new component instance.
     */
    public function __construct()
    {
        //
        $response = Http::get('http://127.0.0.1:9090/blog');
        $blogs = $response->json();
        $perPage = 8;
        $currentPage = LengthAwarePaginator::resolveCurrentPage();
        $currentItems = array_slice($blogs, ($currentPage - 1) * $perPage, $perPage);
        $this->blogs = new LengthAwarePaginator($currentItems, count($blogs), $perPage);
    }

    /**
     * Get the view / contents that represent the component.
     */
    public function render(): View|Closure|string
    {
        return view('components.blog');
    }
}
