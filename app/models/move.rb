class Move < ApplicationRecord
  belongs_to :player

  def clean_move_url(url)
    URI.decode(url.split('/')[-1].tr('_', ' ').to_s.gsub(" %26","\'s"))
  end

  def unique_end_points_game_moves(player)
    list_of_moves = player.moves
    array_unique_list = []




    list_of_moves.each do |move|
      array_unique_list << clean_move_url(move.from_point)
      array_unique_list << clean_move_url(move.to_point)
    end
    array_unique_list.uniq.to_a

  end

  def make_key_list(player)
    key_list = [*1..(unique_end_points_game_moves(player).size)]
    key_list
  end

  def make_hash_node(player)
    # binding.pry
    zipped = unique_end_points_game_moves(player).zip(make_key_list(player))
    # binding.pry
    zipped
    # color: {background:'pink', border:'purple'}
  end


  def make_hash_edge(player, node)
    array_of_edge_hash = []
    player.moves.each do |move|
      array_of_edge_hash << Hash[from: node[clean_move_url(move.from_point)], to: node[clean_move_url(move.to_point)]]
    end
    array_of_edge_hash.to_a
  end
  #
  # def asign_node_ids_to_edge(node, edge)
  #   node.each do |key, value|
  #     [edge.first[:from]]
  #   end
  #
  #   # @unique_endpoints_hash.first[@usable_edges.first[:from]]
  # end

  # var edges = new vis.DataSet([
  #     {from: 1, to: 3},
  #     {from: 1, to: 2},
  #     {from: 2, to: 4},
  #     {from: 2, to: 5}
  # ]);

end
