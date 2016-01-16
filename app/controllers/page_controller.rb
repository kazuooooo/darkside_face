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

  def face_detect(image_url)
    url = URI.parse("http://apius.faceplusplus.com/v2/detection/detect?api_key=#{Settings.api_key}&api_secret=#{Settings.api_secret}&url=#{image_url}")
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    if res.code == '200'
      result = JSON.parse(res.body)
    else
      puts "OMG!! #{res.code} #{res.message}"
    end
    result
  end
end
