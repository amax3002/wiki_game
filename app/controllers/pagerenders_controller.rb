class PagerendersController < ApplicationController
  before_action :set_pagerender, only: [:show, :edit, :update, :destroy]

  # GET /pagerenders
  # GET /pagerenders.json
  def index
    @pagerenders = Pagerender.all
  end

  # GET /pagerenders/1
  # GET /pagerenders/1.json
  def show
    @pagerender = Pagerender.find(params[:id])
    wiki_path = URI(@pagerender.url).path
    redirect_to "/wikipedia#{wiki_path}"
  end


  # GET /pagerenders/new
  def new
    @pagerender = Pagerender.new
  end

  # GET /pagerenders/1/edit
  def edit
  end

  # POST /pagerenders
  # POST /pagerenders.json
  def create
    @pagerender = Pagerender.new(pagerender_params)

    respond_to do |format|
      if @pagerender.save
        format.html { redirect_to @pagerender, notice: 'Pagerender was successfully created.' }
        format.json { render :show, status: :created, location: @pagerender }
      else
        format.html { render :new }
        format.json { render json: @pagerender.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pagerenders/1
  # PATCH/PUT /pagerenders/1.json
  def update
    respond_to do |format|
      if @pagerender.update(pagerender_params)
        format.html { redirect_to @pagerender, notice: 'Pagerender was successfully updated.' }
        format.json { render :show, status: :ok, location: @pagerender }
      else
        format.html { render :edit }
        format.json { render json: @pagerender.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pagerenders/1
  # DELETE /pagerenders/1.json
  def destroy
    @pagerender.destroy
    respond_to do |format|
      format.html { redirect_to pagerenders_url, notice: 'Pagerender was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_pagerender
    @pagerender = Pagerender.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pagerender_params
    params.require(:pagerender).permit(:url)
  end
end
