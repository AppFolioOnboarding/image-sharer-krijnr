class ImagesController < ApplicationController
  def show
    @image = Image.find(params[:id])
  end

  def create
    @image = Image.new image_params
    if @image.save
      redirect_to @image
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    @image = Image.find_by id: params[:id]
    @image&.destroy
    redirect_to images_url
  end

  def new
    @image = Image.new # instance variable gets passed to template
  end

  def index
    @images = if params[:tag_filter]
                Image.tagged_with(params[:tag_filter]).order('created_at DESC')
              else
                Image.all.order('created_at DESC')
              end
  end

  private

  def image_params
    params.require(:image).permit(:path, :tag_list)
  end
end
