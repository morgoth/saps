jQuery(function ($) {
    $("#players img").click(function () {
        var image = $(this);
        if (image.next(".hidden").is(":hidden")) {
            image.next(".hidden").slideDown("normal");
        } else {
            image.next(".hidden").fadeOut("fast");
        }
    });
});
