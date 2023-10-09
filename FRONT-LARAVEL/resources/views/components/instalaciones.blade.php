 <!--==========================
      Venue Section
    ============================-->
    <section id="venue" class="wow fadeInUp">

        <div class="container-fluid">

          <div class="section-header">
            <h2>Conoce nuestras instalaciones</h2>
            <p>Event venue location info and gallery</p>
          </div>

          <div class="row no-gutters">
            <div class="col-lg-6 venue-map ">
              {{-- <iframe class="" src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d12097.433213460943!2d-74.0062269!3d40.7101282!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0xb89d1fe6bc499443!2sDowntown+Conference+Center!5e0!3m2!1smk!2sbg!4v1539943755621" frameborder="0" style="border:0" allowfullscreen></iframe> --}}
              <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1206.8126562260993!2d-69.46892276067523!3d-14.32145614235334!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9166914e149beb25%3A0x8a6aeaa289396b6b!2sEscuela%20Jose%20Carlos%20Mari%C3%A1tegui!5e1!3m2!1ses!2spe!4v1687134985836!5m2!1ses!2spe" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
            </div>

            <div class="col-lg-6 venue-info">
              <div class="row justify-content-center">
                <div class="col-11 col-lg-8">
                  <h3>¡Bienvenido</h3>
                  <p>Nos complace que estés aquí para conocer nuestras instalaciones. En este lugar, te invitamos a descubrir cada rincón y disfrutar de todo lo que tenemos para ofrecerte. Desde espacios amplios y modernos hasta ambientes acogedores, nuestras instalaciones han sido diseñadas pensando en tu comodidad y satisfacción.</p>
                </div>
              </div>
            </div>
          </div>

        </div>

        <div class="container-fluid venue-gallery-container">
          <div class="row no-gutters">
          @foreach ($galeriaubicacions as $ubicacion)


            <div class="col-lg-3 col-md-4">
              <div class="venue-gallery page-header ">
                <a href="{{ $ubicacion['foto'] }}" class="venobox" data-gall="venue-gallery">
                  <img src="{{ $ubicacion['foto'] }}" alt="" class="img-fluid">
                </a>
              </div>
            </div>
            @endforeach
          </div>
        </div>

      </section>

      <style> .page-header {
        position: relative;
        background-size: cover;
        /* height: 100vh; Ajusta la altura según tus necesidades */


    }

    .page-header:before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(6, 12, 34, 0.8);

    }</style>
