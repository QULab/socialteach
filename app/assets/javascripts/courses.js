var ready = function() {

$('div.list-group-item.chapter').hover(function(event){
  Graph.highlight($(event.target).data("node-id"))
})

$('div.list-group-item.chapter').mouseleave(function(event){
  Graph.unHighlight($(event.target).data("node-id"))
})
};

$(document).ready(ready);
$(document).on('page:load', ready);
