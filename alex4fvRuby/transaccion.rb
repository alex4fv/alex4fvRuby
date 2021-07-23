require 'net/http'
require 'uri'
require 'json'

uri = URI.parse("https://sandbox.wompi.co/v1/transactions")
request = Net::HTTP::Post.new(uri)
request.content_type = "application/json"
request["Accept"] = "application/json"
request["Authorization"] = "Bearer pub_test_oQKvM3LK6naYCKVmIS2oXj4yFseHgbRl"
request.body = JSON.dump({
  "acceptance_token" => "eyJhbGciOiJIUzI1NiJ9.eyJjb250cmFjdF9pZCI6MSwicGVybWFsaW5rIjoiaHR0cHM6Ly93b21waS5jby93cC1jb250ZW50L3VwbG9hZHMvMjAxOS8wOS9URVJNSU5PUy1ZLUNPTkRJQ0lPTkVTLURFLVVTTy1VU1VBUklPUy1XT01QSS5wZGYiLCJmaWxlX2hhc2giOiIzZGNkMGM5OGU3NGFhYjk3OTdjZmY3ODExNzMxZjc3YiIsImppdCI6IjE1ODU4NDE2MTUtNDU2MTgiLCJleHAiOjE1ODU4NDUyMTV9.bwBa-RjN3euycqeXVroLWwUN1ZRY1X11I4zn1y5nMiY",
  "amount_in_cents" => 3000000,
  "currency" => "COP",
  "customer_email" => "example@wompi.co",
  "payment_method" => {
    "type" => "CARD",
    "token" => "tok_prod_280_32326B334c47Ec49a516bf1785247ba2",
    "installments" => 2
  },
  "payment_source_id" => 1234,
  "redirect_url" => "https://mitienda.com.co/pago/resultado",
  "reference" => "TUPtdnVugyU40XlkhixhhGE6uYV2gh89",
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

response = Net::HTTP.start(uri.hostname, uri.port, uri.query, req_options, uri.request_uri) do |http|
 		http.request(request)

	end

puts reci=JSON.parse(response.body)

# response.code
# response.body