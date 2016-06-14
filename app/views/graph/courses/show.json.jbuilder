json.nodes @chapters do |node|
  json.data do
    json.id node.id
    json.name node.shortname
    json.color "#ff0000"
  end
end
json.edges @edges do |node, succ|
  json.data do
    json.source node.id
    json.target succ.id
    json.color "#6fb1fc"
  end
end
