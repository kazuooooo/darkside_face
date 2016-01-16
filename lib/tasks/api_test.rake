require 'net/http'
desc "Generate report"
task :api_test => :environment do
  url = URI.parse("http://apius.faceplusplus.com/v2/detection/detect?api_key=#{Settings.api_key}&api_secret=#{Settings.api_secret}&url=http%3A%2F%2Fwww.faceplusplus.com%2Fwp-content%2Fthemes%2Ffaceplusplus%2Fassets%2Fimg%2Fdemo%2F1.jpg%3Fv%3D2&attribute=age%2Cgender%2Crace%2Csmiling%2Cpose%2Cglass")
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
