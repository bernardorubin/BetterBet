// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require chosen-jquery
//= require jquery_ujs
//= require_tree .
//= require highcharts
// require Chart.bundle
//= require chartkick
//= require bootstrap-sprockets


$(document).ready(function(){
  $('.toggleAnalysis').on('click', function(){
    $('.betHub, .toggleBet').slideToggle().promise().done(function(){
      $('.toggleAnalysis').parent().toggleClass('col-md-12');
      $('.toggleAnalysis').parent().toggleClass('col-md-4');
    });

    $('.analysis').slideToggle();

  });
  $('.toggleBet').on('click', function(){
    $('.betHub, .toggleAnalysis').slideToggle();
    $(this).parent().toggleClass('col-md-12');
    $(this).parent().toggleClass('col-md-4');
    $('.placeABet').slideToggle();
  });

  $('.toggleFundamentals').on('click', function(){
    $('#fundamentals').slideToggle();
    // TODO CHANGE FUNCTION TO RGB
    var color = Math.floor((Math.random() * 655366) + 1);
    $('body').css('background-color', `#${color}`);
  });
  $('.toggleTechnicals').on('click', function(){
    $('#technicals').slideToggle();
    $('body').css('background-color', '#002b36');
  });
  console.log('Welcome To Stock Robot');
})
