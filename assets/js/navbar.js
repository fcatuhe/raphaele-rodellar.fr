// $(document).ready(function () {
//   $('.navbar-burger').on('click', function (e) {
//     $('#burger').toggleClass('open')
//     $('.dark-backdrop').toggleClass('in')
//     // if ($('.navbar-menu').hasClass('show')) {
//     //   closeMenu();
//     //   console.log('fermer');
//     // } else {
//     //   openMenu();
//     //   console.log('ouvrir');
//     // }
//   })

//   $('.dark-backdrop').on('click', function (e) {
//     if ($('.dark-backdrop').hasClass('in')) {
//       $('#burger').toggleClass('open')
//       closeMenu()
//       // console.log('fermer avec darkdiv')
//     }
//   })

//   $('.nav-link').on('click', function (e) {
//     if ($('.navbar-menu').hasClass('show')) {
//       $('#burger').toggleClass('open')
//       closeMenu()
//       // console.log('fermer avec nav')
//     } else {
//       openMenu()
//       // console.log('ouvrir avec nav')
//     }
//   })

//   function openMenu() {
//     $('.navbar-menu').addClass('show')
//     $('.dark-backdrop').addClass('in')
//   }

//   function closeMenu() {
//     $('.navbar-menu').removeClass('show')
//     $('.dark-backdrop').removeClass('in')
//   }

//   //////////////// menu sticky
//   var nav = $('nav')
//   var hauteurMenu = nav.height()

//   $(window).on('resize', function (e) {
//     if (window.innerWidth > 992) {
//       if ($('.navbar-menu').hasClass('show')) {
//         closeMenu()
//         $('.navbar-menu').removeClass('show')
//       }
//     }
//   })

//   $(window).scroll(function () {
//     //scrollTop()=> retourne la position de la barre de défilement de l'element
//     //au démarage=0
//     var scroll = $(this).scrollTop()
//     //si la position de la barre de defilement de windowsest >= à la position haute du header
//     if (scroll >= hauteurMenu) {
//       nav.addClass('sticked')
//     } else {
//       nav.removeClass('sticked')
//     }
//   })

//   $(window).trigger('scroll')
// })
