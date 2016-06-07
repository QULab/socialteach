var json_chapter = "{\"nodes\": [{\"data\": {\"id\": \"1\",\"name\": \"Activity 1\",\"color\": \"#FF0000\"}}, {\"data\": {\"id\": \"2\",\"name\": \"Activity 2\",\"color\": \"#FF0000\"}}, {\"data\": {\"id\": \"3\",\"name\": \"Activity 3\",\"color\": \"#6FB1FC\"}}, {\"data\": {\"id\": \"4\",\"name\": \"Activity 4\",\"color\": \"#FF0000\"}}],\"edges\": [{\"data\": {\"source\": \"1\",\"target\": \"2\",\"color\": \"#FF0000\"}}, {\"data\": {\"source\": \"1\",\"target\": \"3\",\"color\": \"#6FB1FC\"}}, {\"data\": {\"source\": \"2\",\"target\": \"4\",\"color\": \"#FF0000\"}}, {\"data\": {\"source\": \"3\",\"target\": \"4\",\"color\": \"#6FB1FC\"}}]}";


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
  loadGraph("activities", node.id())
  setupGraph(json_chapter);
});

}
