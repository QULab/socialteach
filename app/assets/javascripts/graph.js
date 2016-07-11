Graph = {};
var node_type;

function loadGraph(type, id){
$.ajax({
        url:  "/graph/" + type + "/" + id,
        dataType: "json",
        success: function(data) {
          node_type = type;
          setupGraph(data);
        }
    });
}

function setupGraph(json){
$('#cy').cytoscape({
	layout: {
		name: 'breadthfirst',
		directed: 'true'
	},

	style: cytoscape.stylesheet()
		.selector('node')
			.css({
				'shape': 'roundrectangle',
				'width': '100',
				'height': '50',
				'content': 'data(name)',
				'text-valign': 'center',
				'text-outline-width': 2,
				'text-outline-color': 'data(color)',
				'background-color': 'data(color)',
				'color': '#fff'
			})
		.selector('edge')
			.css({
				'curve-style': 'bezier',
				'target-arrow-shape': 'triangle',
				'line-color': 'data(color)',
				'target-arrow-color': 'data(color)'
			})
      .selector(':selected')
        .css({
          'border-width': 3,
          'border-color': '#333'
      })
      .selector('.highlighted')
        .css({
          'border-width': 15,
          'border-color': '#000',
          'border-opacity': 0.3
        }),
	elements: json,

	ready: function(){
		window.cy = this;
	}

});

cy.on('click', 'node', function(evt){
  var node = evt.cyTarget;
  console.log( 'clicked node ' + node.id() );
  console.log( 'type: ' + node_type);
  if (node_type == "courses"){
    window.location = "/instructor/chapters/" + node.id() + "/edit";
  }
  if (node_type == "chapters"){
    window.location = "/instructor/activities/" + node.id() + "/edit";
  }
});

cy.on('mouseover', 'node', function(evt){
  var node = evt.cyTarget;
  $("div.list-group-item[data-node-id=" + node.id() + "]").addClass('highlighted');
  Graph.highlight(node.id());
});

cy.on('mouseout', 'node', function(evt){
  var node = evt.cyTarget;
  $("div.list-group-item[data-node-id=" + node.id() + "]").removeClass('highlighted');
  Graph.unHighlight(node.id());
});

Graph.highlight = function(id){
  cy.$('#' + id).addClass('highlighted');
};

Graph.unHighlight = function(id){
  cy.$('#' + id).removeClass('highlighted');
};

}
