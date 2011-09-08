// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

// TODO: move to separate file
jQuery(function($) {
    $('#menu > li').bind('mouseover', jsddm_open);
    $('#menu > li').bind('mouseout',  jsddm_timer);

    $("#players img").click(function() {
        if ($(this).next(".hidden").is(":hidden")) {
            $(this).next(".hidden").slideDown("normal");
        } else {
            $(this).next(".hidden").fadeOut("fast");
        }
    });
});

//jQuery Simple Drop-Down Menu Plugin
var timeout    = 300,
    closetimer = 0,
    ddmenuitem = 0;

function jsddm_open() {
    jsddm_canceltimer();
    jsddm_close();
    ddmenuitem = $(this).find('ul').css('visibility', 'visible');
}

function jsddm_close() {
    if (ddmenuitem) ddmenuitem.css('visibility', 'hidden');
}

function jsddm_timer() {
    closetimer = window.setTimeout(jsddm_close, timeout);
}

function jsddm_canceltimer() {
    if (closetimer) {
        window.clearTimeout(closetimer);
        closetimer = null;
    }
}
document.onclick = jsddm_close;
