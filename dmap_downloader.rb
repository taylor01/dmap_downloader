require 'open-uri'
require 'net/https'

(1..1000).each do |n|
  puts "Looking for DMAP#{n}.JPG"
  
  uri = URI.parse("https://static.musictoday.com/store/bands/6/product_large/DMAP#{n}.JPG")
  
  # Net::HTTP.start(url.host, url.port) do |http|
  #   response = http.head(url.path)
  #   case response
  #   when Net::HTTPSuccess, Net::HTTPRedirection
  #     case response.content_type
  #     when "image/png", "image/gif", "image/jpeg"
  #       open("images/DMAP#{n}.JPG", 'wb') do |file|
  #         file << open("http://static.musictoday.com/store/bands/6/product_large/DMAP#{n}.JPG").read
  #       end
  #     else
  #       puts "No Image"
  #     end
  #   else
  #     puts "No Image"
  #   end
  # end
  #
  #
  puts "trying #{uri}"
  request = Net::HTTP.new(uri.host, uri.port)
  request.use_ssl = true
  request.verify_mode = OpenSSL::SSL::VERIFY_NONE

  response = request.request_head uri.path

  puts response.code.to_i

  if response.code.to_i == 200
    puts "Found a file DMAP#{n}.JPG"

    open("images/DMAP#{n}.JPG", 'wb') do |file|
      file << open("https://static.musictoday.com/store/bands/6/product_large/DMAP#{n}.JPG").read
    end
  end
end
