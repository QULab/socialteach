var ready = function() {

$('a.list-group-item.chapter').hover(function(event){

  // var previous = $(this).closest(".list-group").children(".active");
  // previous.removeClass('active');
  // $(event.target).closest('.list-group-item').addClass('active');
})
};

$(document).ready(ready);
$(document).on('page:load', ready);
