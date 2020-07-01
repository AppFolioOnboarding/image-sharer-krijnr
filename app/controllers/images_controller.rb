class ImagesController < ApplicationController
  def show
    @image = Image.find(params[:id])
  end

  def create
    @image = Image.new image_params
    if @image.save
      redirect_to @image
    else
      render 'new', status: 422
    end
  end

  def new
    @image = Image.new # instance variable gets passed to template
  end

  private

  def image_params
    params.require(:image).permit(:path)
  end
end
