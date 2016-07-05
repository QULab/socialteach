json.nodes @activities do |node|
  json.data do
    json.id node.id
    json.name node.shortname
    json.color node.color
  end
end
json.edges @edges do |node, succ|
  json.data do
    json.source node.id
    json.target succ.id
    json.color "#5bc0de"
  end
end
