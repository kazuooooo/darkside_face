class PageController < ApplicationController
  def index
    @image = Image.new
  end

  def upload
    @image = Image.new(params.require(:image).permit(:image, :remote_image_url))
    if @image.save
      redirect_to "/dot/#{@image.id}"
    else
      render action: :new
    end
  end

  def dot
    @image = Image.find(params[:id])
    http_client = HTTPClient.new
    url = "https://api.imgur.com/3/image"
    File.open("#{Rails.root}/public#{@image.image_url}") do |file|
      body = { 'image' => file }
      @res = http_client.post(URI.parse(url), body, { 'Authorization' => 'Client-ID ' + "87dedca5a13015e" })
      result_hash = JSON.load(@res.body)
      @image.url = result_hash['data']['link']
      @image.save
    end
    redirect_to "/view/#{@image.id}"
  end

  def view
    @image = Image.find(params[:id])
  end
end
