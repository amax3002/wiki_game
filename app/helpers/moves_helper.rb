module MovesHelper

  def game_move_count
    Move.where(:player_id => current_player.id).count
  end

  def game_move_count_funny_message
    if game_move_count < 2
      "Play!"
    elsif game_move_count.between?(2, 5)
      "Keep Going!"
    elsif game_move_count.between?(6, 9)
      "You are still in this, don't stop!"
    elsif game_move_count.between?(10, 11)
      "Double digits, don't feel bad, it happens"
    elsif game_move_count.between?(12, 13)
      "I mean never to me...."
    elsif game_move_count.between?(14, 15)
      "...or anyone that I know."
    elsif game_move_count.between?(16, 19)
      "Whatever, as long as you haven't the 20's who am I to judge."
    elsif game_move_count.between?(20, 20)
      "20 moves. I am \"impressed\"."
    elsif game_move_count.between?(21, 22)
      "You know you can cheat by opening a new tab, going to wikipedia, and trying there."
    elsif game_move_count.between?(23, 24)
      "There is no need to public embarrass yourself like this."
    elsif game_move_count.between?(25, 30)
      "You should feel bad. I feel bad for you."
    elsif game_move_count.between?(31, 32)
      "O.M.G. please give up"
    elsif game_move_count.between?(33, 34)
      "STOOOOOOOP"
    elsif game_move_count.between?(35, 36)
      "Are you even listening to me?"
    elsif game_move_count.between?(37, 99)
      "I hate you."
    elsif game_move_count.between?(100, 200)
      "What are you doing with your life???"
    else
      ""
    end
  end

  def gametimer(game_being_timed)
    first_move = Move.where(:player_id => current_player.id).first
    last_move = Move.where(:player_id => current_player.id).last

    seconds_diff = (first_move.created_at - last_move.created_at).to_i.abs

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
  end

  def gametimer_leaderboard(player)
    first_move = player.moves.first
    last_move = player.moves.last

    seconds_diff = (first_move.created_at - last_move.created_at).to_i.abs

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
  end

end
