<?php

namespace App\View\Components;

use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\Http;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\View\Component;

class Testimonial extends Component
{

    public $videos;

    /**
     * Create a new component instance.
     */
    public function __construct()
    {

        //
        $response = Http::get('http://127.0.0.1:9090/video');
        $videos = $response->json();
        $perPage = 6;
        $currentPage = LengthAwarePaginator::resolveCurrentPage();
        $currentItems = array_slice($videos, ($currentPage - 1) * $perPage, $perPage);
        $this->videos = new LengthAwarePaginator($currentItems, count($videos), $perPage);
    }

    /**
     * Get the view / contents that represent the component.
     */
    public function render(): View|Closure|string
    {
        return view('components.testimonial');
    }
}
