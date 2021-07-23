require 'sinatra'
require 'json'
require 'rest-client'

url = 'https://production.wompi.co/v1/merchants/pub_prod_p4m6l17wwHPAkaYUBLdY1IAeGQfhR9Xn'

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

puts result["data"]["presigned_acceptance"]["permalink"]

end
#puts response.code
#{number:'4242424242424242', exp_month: '06', exp_year: '29', cvc: '123',card_holder: 'Pedro Pérez'}


url = 'https://production.wompi.co/v1/tokens/card'

response = RestClient::Request.new(
	:method => :post,
	:url => url,
	:payload => {
    acceptance_token: "#{token}",
    amount_in_cents: 2350000,
    currency: "COP",
    customer_email: "pepito_perez@example.com",
    reference: "2322ar3234ea4",
    payment_method: 
        {
            type: "NEQUI",
            phone_number: "3107654321"
        }
    
}
)

result = JSON.parse response.to_str

if result == ""
@token_pago = "Pago Rechazado"
else
@token_pago = "Pago Realizado"
end



