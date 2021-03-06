class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :authorize!, except: [:index]

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    session[:game_id] = @game.id
    wiki_path = @game.create_start_wiki_path
    @player = Player.create(user_id: current_user.id, game_id: @game.id)

    session[:player_id] = @player.id
    redirect_to "/wikipedia#{wiki_path}"
  end

  def new
    @game = Game.new
  end

  def edit
  end

  def create
    @game = Game.create(
      start_point: WikiData.new.article_size_generate,
      end_point: WikiData.new.article_size_generate
    )

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game }
        format.json { render :show, status: :created, location: @game }
        flash[:success] = "Successfully Created a Game!"
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

private
  def game_params
    params.permit(:game).permit(:start_point, :end_point)
  end
end
