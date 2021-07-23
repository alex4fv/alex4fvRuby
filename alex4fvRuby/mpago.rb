def token_trans 
require 'sinatra'
require 'json'
require 'rest-client'

url = 'https://sandbox.wompi.co/v1/merchants/pub_test_oQKvM3LK6naYCKVmIS2oXj4yFseHgbRl'

response = RestClient::Request.new(
	:method => :get,
	:url => url,
	
).execute

result = JSON.parse response.to_str
puts response
unless result["data"][0]== ""

#puts "*********************************************************************"
token = result["data"]["presigned_acceptance"]["acceptance_token"]
@token_pro = "Token Generado para el pago   #{token}"
#puts "*********************************************************************"

#puts result["data"]["presigned_acceptance"]["permalink"]

end
#puts response.code
#{number:'4242424242424242', exp_month: '06', exp_year: '29', cvc: '123',card_holder: 'Pedro Pérez'}



uri = URI.parse("https://sandbox.wompi.co/v1/transactions")
request = Net::HTTP::Post.new(uri)
request.content_type = "application/json"
request["Accept"] = "application/json"
request["Authorization"] = "Bearer prv_test_dU7tqbr106jlD9VgIZkXxaqyAKYd97yR"
request.body = JSON.dump({
  "acceptance_token" => "#{token}",
  "amount_in_cents" => 3000000,
  "currency" => "COP",
  "customer_email" => "example@wompi.co",
  "payment_method" => {
    "type" => "CARD",
    "token" => "prv_test_dU7tqbr106jlD9VgIZkXxaqyAKYd97yR",
    "installments" => 2
  },
  "payment_source_id" => 1234,
  "redirect_url" => "https://dtqrestaurantes.com",
  "reference" => "TUPtdnVugyU40XlkhixhhGE6uYV2jj89",
  "customer_data" => {
    "phone_number" => "573307654321",
    "full_name" => "Juan Alfonso Pérez Rodríguez"
  },
  "shipping_address" => {
    "address_line_1" => "Calle 34 # 56 - 78",
    "address_line_2" => "Apartamento 502, Torre I",
    "country" => "CO",
    "region" => "Cundinamarca",
    "city" => "Bogotá",
    "name" => "Pepe Perez",
    "phone_number" => "573109999999",
    "postal_code" => "111111"
  }
})

req_options = {
  use_ssl: uri.scheme == "https",
}

responde = Net::HTTP.start(uri.hostname, uri.port, uri.query, req_options, uri.request_uri) do |http|
 		http.request(request)

	end

unless responde.body==""
puts responde.body
return responde.body
end 
#JSON.parse()
puts result["data"]["status"]
#result = JSON.parse responde.to_str

# JSON.parse responde.to_str


end
