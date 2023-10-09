<section id="schedule" class="section-with-bg">
    <div class="container wow fadeInUp">
        <div class="section-header">
            <h2>Que dicen nuestros Alumnos</h2>
            <p>Here is our event schedule</p>
        </div>
        <div class="container">
            <div class="row">
                <div class="col">
                    <hr>
                </div>
            </div>
        </div>
        <div class="container flex">
            @foreach ($videos as $video)
            <div class="row">
                <div
                    class="contenidovideo p-2 col-md-6 col-xl-6 col-sm-12 d-flex justify-content-center align-items-center">
                    <div class="embed-responsive embed-responsive-16by9">
                        <div class="embed-responsive-item ">
                            <div class="videox fluid-width-video-wrapper">
                                <iframe class="videox" title="Estudia Ing. Ambiental - UPeU"
                                src="https://www.youtube.com/embed/{{ getYoutubeVideoId($video['videolink']) }}"
                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                                allowfullscreen="" name="fitvid0"></iframe>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="p-2 col-md-6 col-xl-6 col-sm-12">
                    <div class="linea  ">
                        <div class="lineacontenido  ">
                            <div class="row pt-2">
                                <div class="col-sm-12 " style="width:100% ; padding: 0px ;">
                                    <div class="col-sm-12"
                                        style="width:100%; font-size: 50px; font-weight: 800; font-family: Arial, Helvetica, sans-serif">
                                        {{ $video['estudiante'] }}
                                    </div>
                                </div>
                            </div>
                            <div class="row pt-3">
                                <div class="col-sm-12 " style="width:100% ; padding: 0px ;">
                                    <div class="col-sm-12 "
                                        style="font-size: 12px; font-weight: 800; width:100%; color:#f82249;font-family: Arial, Helvetica, sans-serif;">

                                        <samp>𒆜一一一一一一一一</samp> {{ $video['descripccion'] }}
                                    </div>
                                </div>
                            </div>
                            <div class="row pt-3">
                                <div class="col-sm-12 " style="width:100% ; color:white; font-size: 20px; font-weight: 800; ">
                                    <div class="col-sm-12 " style="width:100%;background: rgba(6, 12, 34, 0.98)">
                                        {{ $video['seccion'] }}
                                    </div>
                                </div>
                            </div>
                            <div class="row pt-3">
                                <a href="#" class="col-sm-12" style="font-weight: bold;" >
                                    <svg  class="iconss" fill="white" xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 448 512"><!--! Font Awesome Free 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M438.6 278.6c12.5-12.5 12.5-32.8 0-45.3l-160-160c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L338.8 224 32 224c-17.7 0-32 14.3-32 32s14.3 32 32 32l306.7 0L233.4 393.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0l160-160z"/></svg>Conoce mas
                                </a>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            @endforeach
        </div>
    </div>
</section>
@php
function getYoutubeVideoId($url)
{
    $match = preg_match('/[?&]v=([^&#]+)/', $url, $matches);
    if ($match) {
        return $matches[1];
    }
    return null;
}
@endphp

<style>
    .videox {
        border-radius: 20px;
    }

    .linea {
        padding-left: 20px;

    }

    .lineacontenido {
        height: 300px;
        border-left: 2px solid #f82249;
        padding-left: 18px;
        padding-top: 30px;

    }
    .iconss{
        border-radius: 100%;
        background: #f82249;
        padding: 6px;
        width: 30px;
        height: 30px;
    }

    @media screen and (max-width: 770px) {
        .lineacontenido {

        border-left: none;


    }

  }

</style>
