$(document).ready(function () {


  var speed = 750;


  //console.log(topSection2);
  ////////////smooths scroll depuis la flèche du header
  $('a[href^="#"]').on('click', function (e) {
    //je stock la cible du lien
    var cible = $(this).attr('href');
    $('a').removeClass('active');
    $(this).addClass('active');
    //l'animation (animate()) consiste à
    //scroller (scrollTop) vers la coordonnée haute de l'élement ciblé (offset().top)
    $('html,body').animate({
      scrollTop: $(cible).offset().top - 150
    }, speed);
    return false;
  });



  //activation de l'état actif du lien du menu au scroll naturel sans apuyer sur le link
  $(window).scroll(function () {
    //get current sroll position
    var scrollPosition = $(window).scrollTop();
    //get the position of the containers
    var one = $("#section1").offset().top + 70;
    two = $("#section2").offset().top - 250;
    three = $("#section3").offset().top - 200;
    four = $("#section4").offset().top - 200;
    five = $("#section5").offset().top - 200;
    six = $("#section6").offset().top - 200;
    var nav1 = $("#nav1"),
    nav2 = $("#nav2"),
    nav3 = $("#nav3");
    nav4 = $("#nav4");
    nav5 = $("#nav5");
    nav6 = $("#nav6");
    //if the scroll position is the same as the position of the container specified, add the "active" class to the corresponding nav element
    if (scrollPosition < one) {
      $('.nav-item').find('a.nav-link').removeClass("active");
    }

    if (scrollPosition >= one) {
      $('.nav-item').not('#nav1').find('a.nav-link').removeClass("active");
      nav1.find('a.nav-link').addClass("active");
    }

    if (scrollPosition >= two) {
      $('.nav-item').not('#nav2').find('a.nav-link').removeClass("active");
      nav2.find('a.nav-link').addClass("active");
    }

    if (scrollPosition >= three) {
      $('.nav-item').not('#nav3').find('a.nav-link').removeClass("active");
      nav3.find('a.nav-link').addClass("active");
    }


    if (scrollPosition >= four) {
      $('.nav-item').not('#nav4').find('a.nav-link').removeClass("active");
      nav4.find('a.nav-link').addClass("active");
    }

    if (scrollPosition >= five) {
      $('.nav-item').not('#nav5').find('a.nav-link').removeClass("active");
      nav5.find('a.nav-link').addClass("active");
    }

    if (scrollPosition >= six) {
      $('.nav-item').not('#nav6').find('a.nav-link').removeClass("active");
      nav6.find('a.nav-link').addClass("active");
    }

  });


  ////////////smooths scroll depuis logo header
  $('#logo, #logoMobil').on('click', function (e) {
    $('.nav-link').removeClass('active');
    $("html, body").animate({
      scrollTop: $('body').offset().top
    }, speed);
    return false;
  });



});
