var ready = function() {

$('div.list-group-item.activity').hover(function(event){
  $(event.target).addClass('highlighted')
  Graph.highlight($(event.target).data("node-id"))
})

$('div.list-group-item.activity').mouseleave(function(event){
  $(event.target).removeClass('highlighted')
  Graph.unHighlight($(event.target).data("node-id"))
})
};

$(document).ready(ready);
$(document).on('page:load', ready);
