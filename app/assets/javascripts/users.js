//add-ajax-to-unfavorite-user-show
$(function(){
	$('.container').on("click", ".unfavorite", function(event){
    event.stopPropagation();
    $('#recommendations-wrapper').replaceWith('<%= j render :partial => "users/recommendations", :locals => {:user => @user} %>');
  });
});