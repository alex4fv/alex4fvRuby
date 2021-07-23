def mitoken(owner, cardnum, cvc, month, year)

#owner, cardnum, cvc, month, year

require 'net/http'
require 'uri'
require 'json'




uri = URI.parse("http://localhost/v1/tokentj.php")

request = Net::HTTP::Post.new(uri)
request.content_type = "application/json"
request["Accept"] = "*/*"
request["Authorization"] = "Bearer pub_test_oQKvM3LK6naYCKVmIS2oXj4yFseHgbRl"
request = Net::HTTP::Post.new(uri.request_uri)
request.body = JSON.dump({
  "number" => "#{cardnum}",
  "cvc" => "#{cvc}",
  "exp_month" => "#{month}",
  "exp_year" => "#{year}",
  "card_holder" => "#{owner} "
})

req_options = {
  use_ssl: uri.scheme == "https",
}

	response = Net::HTTP.start(uri.hostname, uri.port, uri.query, req_options, uri.request_uri) do |http|
 		http.request(request)

	end
reci=JSON.parse(response.body)
puts reci["data"]["id"]
puts reci["data"]["created_at"]
puts reci["data"]["brand"]
puts reci["data"]["name"]
puts reci["data"]["last_four"]
puts reci["data"]["bin"]
puts reci["data"]["exp_year"]
puts reci["data"]["exp_month"]
puts reci["data"]["card_holder"]
puts reci["data"]["expires_at"]

puts response.body
#puts "***trajeta**********************************************"
#puts response.code             # => '404'
                               #  Note: Returned (status) code is a string e.g. '404'
#puts response.message          # => 'Not Found'
#puts response.body
#puts response.content_type     # => 'text/html; charset=UTF-8'
#puts response['content-type']	# => 'text/html; charset=UTF-8'
                               #  Note: Headers are always downcased
                               #        e.g. use 'content-type' not 'Content-Type'

   

return reci
end



