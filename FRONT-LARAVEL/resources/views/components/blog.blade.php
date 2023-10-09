    <!--==========================
      Subscribe Section
    ============================-->
    <section id="subscribe">
        <div class="container wow fadeInUp">
          <div class="section-header">
            <h2>Nuestra Misión</h2>
            <p>“Somos una comunidad universitaria de la Iglesia Adventista del Séptimo Día que modela personas a fin de que sean Ingenieros de Sistemas íntegros, misioneros e innovadores basados en la cosmovisión bíblica-cristiana para servir a Dios y a la humanidad.”</p>
          </div>
          <div class="section-header">
            <h2>Nuestra Visión</h2>
            <p>“Ser referentes en el mundo por el modelamiento de Ingenieros de Sistemas íntegros, misioneros e innovadores con un estilo de vida saludable.”</p>
          </div>
        </div>
      </section>



    <!--==========================
      Buy Ticket Section
    ============================-->
    <section id="buy-tickets" class=" section-with-bg wow fadeInUp">
        <div class="container">

          <div class="section-header">
            <h2>Noticias</h2>
            <p>Velit consequatur consequatur inventore iste fugit unde omnis eum aut.</p>
          </div>

          <div class="row ">
            @foreach ($blogs as $blog)
            <div class=" col-lg-4 mt-4">
              <div class=" card mb-5 mb-lg-0">
                <div class="card-body">
                    <img src="{{ $blog['foto'] }}" class="card-img-top" alt="...">
                    <div class="card-body">
                      <h5 class="card-title">{{ $blog['titulo'] }}</h5>
                      <div class="card-text ">Fecha: {{ date('Y-m-d', strtotime($blog['created_at'])) }}</div>
                      <p class="card-text p-0 m-0">Hora: {{ date('H:i', strtotime($blog['created_at'])) }}</p>                    </div>
                  <hr>
                  <div class="text-center">
                    <button type="button" class="btn">Leer mas</button>
                  </div>
                </div>
              </div>
            </div>
            @endforeach
        </div>

      </section>

