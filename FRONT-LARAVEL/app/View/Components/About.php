<?php

namespace App\View\Components;

use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\Http;
use Illuminate\View\Component;

class About extends Component
{
     public $abouts;
    /**
     * Create a new component instance.
     */
    // public function __construct()
    // {
    //     //
    //     $response = Http::get('http://127.0.0.1:9090/about');
    //     $this->abouts = $response->json();
    // }

    /**
     * Get the view / contents that represent the component.
     */
    public function render(): View|Closure|string
    {
        return view('components.about');
    }
}
