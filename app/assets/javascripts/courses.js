var ready = function() {

$('div.list-group-item.chapter').hover(function(event){
  $(event.target).addClass('highlighted')
  Graph.highlight($(event.target).data("node-id"))
})

$('div.list-group-item.chapter').mouseleave(function(event){
  $(event.target).removeClass('highlighted')
  Graph.unHighlight($(event.target).data("node-id"))
})
};

$(document).ready(ready);
$(document).on('page:load', ready);
