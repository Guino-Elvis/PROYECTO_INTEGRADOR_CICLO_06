     <!--==========================
      Contact Section
    ============================-->

<section id="contact" class="section-bg wow fadeInUp">
    <div class="container">
        <div class="section-header">
            <h2>CONTÁCTENOS</h2>
            <p>Nada está destinado a ofender a los funcionarios.</p>
        </div>

        <div class="row contact-info">

            <div class="col-md-4">
                <div class="contact-address">
                    <i class="ion-ios-location-outline"></i>
                    <h3>DIRECCIÓN</h3>
                    <address>Sandia, Perú</address>
                </div>
            </div>

            <div class="col-md-4">
                <div class="contact-phone">
                    <i class="ion-ios-telephone-outline"></i>
                    <h3>NÚMERO DE TELÉFONO</h3>
                    <p><a href="tel:+155895548855">+1 5589 55488 55</a></p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="contact-email">
                    <i class="ion-ios-email-outline"></i>
                    <h3>CORREO ELECTRÓNICO</h3>
                    <p><a href="http://www.iesmariateguisandia.edu.pe/">www.iesmariateguisandia.edu.pe</a></p>
                </div>
            </div>

        </div>

        <div class="form">
            @if (session('success'))
            <p>{{ session('success') }}</p>
          @endif
            <div id="mini-modal" class="modal">
                <div class="modal-content">
                  <span class="close">&times;</span>
                  @if (session('success'))
                    {{-- <p id="modal-text"></p> --}}
                    <p>{{ session('success') }}</p>
                  @endif
                </div>
              </div>
              <form id="contact-form" action="{{ route('enviar-correo') }}" method="post" role="form" enctype="multipart/form-data">
                @csrf
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <input class="form-control" type="text" name="nombre" placeholder="Your Name" required>
                    </div>
                    <div class="form-group col-md-6">
                        <input class="form-control" type="email" name="destinatario" placeholder="Your Email" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <input class="form-control" type="text" name="asunto" placeholder="Your asunto" required>
                    </div>
                    <div class="form-group col-md-6">
                        <input type="file" name="adjunto">
                    </div>
                </div>
                <div class="form-group">
                    <textarea class="form-control" name="mensaje" id="" rows="5" placeholder="Message"></textarea>
                    <div class="validation"></div>
                  </div>
                <div class="text-center"><button id="open-modal-btn" type="submit" name="send">Enviar</button></div>
            </form>

        </div>
    </div>
</section>

 <style>.modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.4);
  }

  .modal-content {
    background-color: #fefefe;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
  }



  .close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
  }

  .close:hover,
  .close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
  }</style>
 <script>
    document.getElementById("contact-form").addEventListener("submit", function (event) {
        event.preventDefault(); // Evita que el formulario se envíe de forma tradicional

        var form = this;
        var formData = new FormData(form);

        // Realiza la solicitud AJAX
        var xhr = new XMLHttpRequest();
        xhr.open(form.method, form.action);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    // La solicitud se completó correctamente
                    var response = JSON.parse(xhr.responseText);
                    document.getElementById("mini-modal").style.display = "block"; // Muestra el modal
                    document.querySelector("#mini-modal .modal-content p").innerText = response.message; // Muestra el mensaje en el modal
                    // document.getElementById("modal-text").innerText = "Felicitaciones"; // Muestra el mensaje en el modal
                    // document.querySelector("#mini-modal .modal-content p").innerText = "Mensaje Enviado Con Exito"; // Muestra el mensaje en el modal
                    form.reset(); // Restablece el formulario después del envío

                    // Envía el correo electrónico después de mostrar el mensaje de éxito
                    enviarCorreo();
                } else {
                    // Ocurrió un error durante la solicitud
                    console.error('Error en la solicitud AJAX.');
                }
            }
        };
        xhr.send(formData);
    });

    document.getElementsByClassName("close")[0].addEventListener("click", function () {
        document.getElementById("mini-modal").style.display = "none";
    });

    function enviarCorreo() {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '{{ route("enviar-correo") }}');
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.send();
    }
</script>
