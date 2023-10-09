<!--==========================
  Intro Section
============================-->
<section id="intro" class="">
    <div id="myCarousel" class="page-header carousel slide" data-ride="carousel">
      <!-- Indicators -->
      <ol class="carousel-indicators">
        @foreach ($sliders as $index => $slider)
        <li data-target="#myCarousel" data-slide-to="{{ $index }}" class="{{ $index == 0 ? 'active' : '' }}"></li>
        @endforeach
      </ol>

      <!-- Slides -->
      <div class="carousel-inner">
        @foreach ($sliders as $index => $slider)
        <div class="page-header carousel-item {{ $index == 0 ? 'active' : '' }}">
          <img class="imgg" src="{{ $slider['foto'] }}"style="object-fit: cover;">
          <div class="slide-in-fwd-center intro-container wow fadeIn" style="padding-bottom: 360px">
            <h1 class="mb-4 pb-0">The Annual<br><span>Marketing</span> Conference</h1>
            <p class="mb-4 pb-0">{{ $slider['descripccion'] }}</p>
            <a href="https://youtu.be/Sog-qzxORhI" class="venobox play-btn mb-4" data-vbtype="video"
              data-autoplay="true"></a>
            <a href="#about" class="about-btn scrollto">About The Event</a>
          </div>
        </div>
        @endforeach
      </div>
    </div>
  </section>


  <style>
    .slide-in-fwd-center {
	-webkit-animation: slide-in-fwd-center 1s cubic-bezier(0.250, 0.460, 0.450, 0.940) both;
	        animation: slide-in-fwd-center 1s cubic-bezier(0.250, 0.460, 0.450, 0.940) both;
}
    /**
 * ----------------------------------------
 * animation slide-in-fwd-center
 * ----------------------------------------
 */
@-webkit-keyframes slide-in-fwd-center {
  0% {
    -webkit-transform: translateZ(-1400px);
            transform: translateZ(-1400px);
    opacity: 0;
  }
  100% {
    -webkit-transform: translateZ(0);
            transform: translateZ(0);
    opacity: 1;
  }
}
@keyframes slide-in-fwd-center {
  0% {
    -webkit-transform: translateZ(-1400px);
            transform: translateZ(-1400px);
    opacity: 0;
  }
  100% {
    -webkit-transform: translateZ(0);
            transform: translateZ(0);
    opacity: 1;
  }
}

    .imgg{
        width: 100%;

    }
   .page-header {
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

    }
    .carousel {
  position: relative;
}

.carousel.pointer-event {
  touch-action: pan-y;
}

.carousel-inner {
  position: relative;
  width: 100%;
  overflow: hidden;

}

.carousel-item {
  position: relative;
  display: none;
  float: left;
  width: 100%;
  margin-right: -100%;
  backface-visibility: hidden;

}

.carousel-item.active,
.carousel-item-next,
.carousel-item-prev {
  display: block;
}

.carousel-item-next:not(.carousel-item-left),
.active.carousel-item-right {
  transform: translateX(100%);
}

.carousel-item-prev:not(.carousel-item-right),
.active.carousel-item-left {
  transform: translateX(-100%);
}


  </style>
