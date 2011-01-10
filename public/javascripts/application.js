$(document).ready(
  function() {
    $("input#user_session_login").focus();
    $('#jsddm > li').bind('mouseover', jsddm_open);
    $('#jsddm > li').bind('mouseout',  jsddm_timer);

    $("#new_comment").submitWithAjax();

    $("#players img").click( function() {
      if ($(this).next(".hidden").is(":hidden")) {
        $(this).next(".hidden").slideDown("normal");
      } else {
        $(this).next(".hidden").fadeOut("fast");
        }
    });
  }
);

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
    if(closetimer)
        {  window.clearTimeout(closetimer);
            closetimer = null;
        }
}
document.onclick = jsddm_close;


//railscasts dynamic comments
jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};
