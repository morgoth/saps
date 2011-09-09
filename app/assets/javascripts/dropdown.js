jQuery(function ($) {
    //  TODO: rewrite
    //jQuery Simple Drop-Down Menu Plugin
    var timeout    = 300,
        closetimer = 0,
        ddmenuitem = 0;

    function jsddm_open () {
        jsddm_canceltimer();
        jsddm_close();
        ddmenuitem = $(this).find('ul').css('visibility', 'visible');
    }

    function jsddm_close () {
        if (ddmenuitem) ddmenuitem.css('visibility', 'hidden');
    }

    function jsddm_timer () {
        closetimer = setTimeout(jsddm_close, timeout);
    }

    function jsddm_canceltimer () {
        if (closetimer) {
            clearTimeout(closetimer);
            closetimer = null;
        }
    }

    $('#menu > li').bind('mouseover', jsddm_open);
    $('#menu > li').bind('mouseout',  jsddm_timer);

    document.onclick = jsddm_close;
});
