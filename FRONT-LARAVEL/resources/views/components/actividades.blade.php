
    <!--==========================
      Gallery Section
    ============================-->
    <section id="gallery" class="wow fadeInUp">

        <div class="container">
          <div class="section-header">
            <h2>Nuestras Actividades</h2>
            <p>Check our gallery from the recent events</p>
          </div>
        </div>

        <div class="owl-carousel gallery-carousel">
            @foreach ($galeriaactividads as $actividad)
            <a href="{{ $actividad['foto'] }}" class="venobox" data-gall="gallery-carousel"><img src="{{ $actividad['foto'] }}" alt=""></a>
            @endforeach
        </div>

      </section>
