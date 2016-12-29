class GamesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  def index
    @games = Game.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 5)
    # @games = Game.all
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
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
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

 def sort_column
   params[:sort] || "start_point"
 end

 def sort_direction
   params[:direction] || "asc"
 end

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:start_point, :end_point)
  end
end
