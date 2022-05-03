$( document ).ready(function() {


  var speed = 750;


    //console.log(topSection2);
    ////////////smooths scroll depuis la flèche du header
    $('a[href^="#"]').on('click', function(e){
      //je stock la cible du lien
      var cible = $(this).attr('href');
      $('a').removeClass('active');
      $(this).addClass('active');
      //l'animation (animate()) consiste à
      //scroller (scrollTop) vers la coordonnée haute de l'élement ciblé (offset().top)
      $('html,body').animate({
        scrollTop:$(cible).offset().top - 56
       },speed);
      return false;
    });

    ////////////smooths scroll depuis btn retour top
    $('#logo').on('click', function(e){
      $("html, body").animate({
        scrollTop:$('body').offset().top
      }, speed);
      return false;
    });



  });
