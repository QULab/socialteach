function loadGraph(type, id){
$.ajax({
        url:  "/graph/" + type + "/" + id,
        dataType: "json",
        success: function(data) {
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
				'shape': 'ellipse',
				'width': '50',
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
  }),
	elements: json,

	ready: function(){
		window.cy = this;
	}

});

cy.on('click', 'node', function(evt){
  var node = evt.cyTarget;
  console.log( 'clicked node ' + node.id() );
  loadGraph("chapters", node.id())
});

}
