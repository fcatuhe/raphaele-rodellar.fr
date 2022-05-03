$(document).ready(function () {

  //////////////// menu sticky
  var nav = $('nav');
  var hauteurMenu = nav.height();


  //comportement du menu en mobil :rendre opaque le site quand on ouvre le menu en mobil
  // affichage de la flèche scroll bottom de la bannière top de la home
  // quand le menu n'est pas déployé
  $('.navbar-burger').on('click', function (e) {
    $('#burger').toggleClass('open');
    if ($('.navbar-menu').hasClass('show')) {
      closeMenu();
    } else {
      openMenu();
    }
  });

  function openMenu() {
    $('nav').addClass('opened');
    // $('.dark-backdrop').addClass('in');
    // $('main').addClass('no-scroll');
    // $('footer').addClass('no-scroll');


  }

  function closeMenu() {
    $('nav').removeClass('opened');
    // $('.dark-backdrop').removeClass('in');
    // $('main').removeClass('no-scroll');
    // $('footer').removeClass('no-scroll');
  }

  $(window).on("resize", function (e) {
    if (window.innerWidth > 992) {
      if ($('.navbar-menu').hasClass('show')) {
        closeMenu();
        $('.navbar-menu').removeClass('show');
      }
    }
  });

  $(window).scroll(function () {
    //scrollTop()=> retourne la position de la barre de défilement de l'element
    //au démarage=0
    var scroll = $(this).scrollTop();
    //si la position de la barre de defilement de windowsest >= à la position haute du header
    if (scroll >= hauteurMenu) {
      nav.addClass('sticked');
    } else {
      nav.removeClass('sticked');

    }
  });

});
