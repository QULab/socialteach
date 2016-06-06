//var json = "{\"nodes\": [{\"data\": {\"id\": \"1\",\"name\": \"Chapter 1\",\"color\": \"#FF0000\",\"faveShape\": \"ellipse\"}}, {\"data\": {\"id\": \"2\",\"name\": \"Chapter 2\",\"color\": \"#FF0000\",\"faveShape\": \"ellipse\"}}, {\"data\": {\"id\": \"3\",\"name\": \"Chapter 3\",\"color\": \"#6FB1FC\",\"faveShape\": \"ellipse\"}}, {\"data\": {\"id\": \"4\",\"name\": \"Chapter 4\",\"color\": \"#FF0000\",\"faveShape\": \"ellipse\"}}, {\"data\": {\"id\": \"5\",\"name\": \"Chapter 5\",\"color\": \"#6FB1FC\",\"faveShape\": \"ellipse\"}}],\"edges\": [{\"data\": {\"source\": \"1\",\"target\": \"2\",\"color\": \"#FF0000\"}}, {\"data\": {\"source\": \"1\",\"target\": \"3\",\"color\": \"#6FB1FC\"}}, {\"data\": {\"source\": \"2\",\"target\": \"4\",\"color\": \"#FF0000\"}}, {\"data\": {\"source\": \"5\",\"target\": \"4\",\"color\": \"#6FB1FC\"}}, {\"data\": {\"source\": \"3\",\"target\": \"5\",\"color\": \"#6FB1FC\"}}]}";

function loadGraph(type, id){
$.ajax({
        url:  "/" + type + "/" + id,
        dataType: "json",
        success: function(data) {
           json = data;
           setupGraph(json);
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
	elements: JSON.parse(json),

	ready: function(){
		window.cy = this;
	}

});

cy.on('click', 'node', function(evt){
  var node = evt.cyTarget;
  console.log( 'clicked node ' + node.id() );
});

}
