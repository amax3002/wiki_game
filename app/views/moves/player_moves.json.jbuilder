

json.edges @usable_edges

json.nodes @unique_endpoints_hash do |key, value|
  json.id value
  json.label key
end
