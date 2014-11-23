// Ajaxify the favorites button!

$(function(){
	$('.favorite-button-wrapper').on("submit", "form", function(event){
		event.preventDefault();
		var action = $(this).attr("action");
		var method = $(this).attr("method");

		$.ajax(action, {
			type: method,
			data: $(this).serialize(),
			dataType: "script"
		});
	});
});