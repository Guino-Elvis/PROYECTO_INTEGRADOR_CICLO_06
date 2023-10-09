 <!--==========================
      Speakers Section
    ============================-->
    <section id="speakers" class="section-with-bg wow fadeInUp">
        <div class="container">
          <div class="section-header">
            <h2>Nuestros Docentes</h2>
            <p>Here are some of our speakers</p>
          </div>

          <div class="row">
            @foreach ($docentes as $docente)
            <div class="col-lg-4 col-md-6">
              <div class="speaker">
                <img src="{{ $docente['foto'] }}" style="width: 100%" alt="Speaker 1" class="img-fluid">
                <div class="details">
                  <h3><a href="speaker-details.html">{{ $docente['nombre'] }},{{ $docente['apellido'] }}</a></h3>
                  <p>{{ $docente['correo'] }}</p>
                  <div class="social">
                    <a href=""><i class="fa fa-twitter"></i></a>
                    <a href=""><i class="fa fa-facebook"></i></a>
                    <a href=""><i class="fa fa-google-plus"></i></a>
                    <a href=""><i class="fa fa-linkedin"></i></a>
                  </div>
                </div>
              </div>
            </div>
            @endforeach
          </div>
        </div>

      </section>
