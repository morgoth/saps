  $(document).ready(
  function()
  {
    $("input#login").focus();
    $("#testowy").smile();
		$("#players img").click( function() {
      if ($(this).next(".hidden").is(":hidden")) {
        $(this).next(".hidden").slideDown("slow");
      } else {
        $(this).next(".hidden").slideUp("fast");
				}
		});

			
  }
  );
