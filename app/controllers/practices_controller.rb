class PracticesController < ApplicationController

  def index
    @practices = Practice.all
  end

  def new
    @practrice = Practice.new
  end

  def show
    @practice = Practice.find([params[:id])
  end

  def edit
    @practice = Practice.find(params[:id])
  end
  def create
    @practice = Practice.new(practice_params)
    if @practice.save
      flash[:notice] = "Practice successfully saved."
      redirect_to 'show'
    else
      render :new
    end

  end

  private
    def practice_params
      params.require(:practice).permit(:first, :second, :third)
    end

end
