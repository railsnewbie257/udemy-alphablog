class PracticeController < ApplicationController

  def show
    @practice = Practice.find(params[:id])
  end

  def edit
    @practice = Practice.find(params[:id])
  end

  def create
    @practice = Practice.new(practice_params)
    if @practice.save
      flash[:notice] = "Practice successfully saved."
    else
      render :new
  end

  def update
    @practice = Practice.find(params[:id])
    if @practice.update(practice_params)
      

  private
    def practice_params
      params.require(:practice).permit(:first, :second, :third)
    end
end
