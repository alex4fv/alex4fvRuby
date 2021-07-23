require 'sinatra'
require "active_record"
require './config/environments'
require './models/appuser'
require './models/pcard'
require './mpago'
require './pcard'


def initialize

@menu = '| <a href="login">Login</a>'
 
end

# ----------------------- https://youtu.be/rRzQXElFNIc DEMO

get '/' do

#@menu = '| <a href="registrarse">www</a>'
 
puts  @menu
@tokenmsg=""
@title = "Ruby Wompi"
  erb :index
end


get '/pictures' do
  
  @title = "Ruby Wompi"
  
  @pictures = picture_urls.map { |url| {
    :picture_url => url,
    :page_url => url.sub(/\.\w+$/, '.html'),
    #:comments => Comment.count(:picture => File.basename(url, '.*'))
  }}


  erb :pictures
end

post '/login' do

 puts "1"
unless params[:password] == "" && params[:email] == ""
#puts "2 #{params[:email]} - #{params[:password]}"
@appuser=Appuser.where("email = ?", params[:email])

	@appuser.each do |rider|
		@myid = rider.id		
		@myname = rider.name
		@myemail = rider.email
		@menu = @myname
		
	end
end 


#redirect '/viaje'





erb :login
end

post '/mpago' do
@tokenreci = token_trans
erb :mpago
end

get '/pcard' do
erb :pcard
end




post '/pcardtoken' do

# && params[:pcarg][:cardnum].nil? && params[:pcarg][:cvc].nil? || params[:pcarg][:month].nil? || params[:pcarg][:year].nil?

puts "*********************************************************"
reci = mitoken( params[:owner], params[:cardnum], params[:cvc], params[:month], params[:year] )

puts reci["data"]["created_at"]
@namet = reci["data"]["name"]
sleep (5)
puts @pcard = Pcard.new(
id_user: 1,
tok: reci["data"]["id"],
created_at: reci["data"]["created_at"],
brand: reci["data"]["brand"],
name: reci["data"]["name"],
last_four: reci["data"]["last_four"],
bin: reci["data"]["bin"],
exp_year: reci["data"]["exp_year"],
exp_month: reci["data"]["exp_month"],
card_holder: reci["data"]["card_holder"],
experies_at: reci["data"]["expires_at"] 
)
 
if @pcard.save 
			
		@tokenmsg = [
		'<h1>Se ha guardado su Tarjeta', 
		@namet, 
		'con éxito</h1><p>¿Desea ingresar una nueva Tarjeta? <a href = "/pcard">Agregar</a></p>',
		'<p>Desea iniciar un Viaje <a href = "/viaje">viaje</a>' 
		].join(" ")
		 
	else
		@tokenmsg = "Error al guardar su tarjeta, inténtelo mas tarde"
		#/redirect '/pcardtoken'	
	
	#	"Sorry, there was an error!"
 	#	render 'new'
    
	end 
 
 

erb :pcardtoken
end

get '/pcardtoken' do

erb :pcardtoken
end


get '/registarse' do
erb :registarse
end

post '/registarse' do

unless params[:registro][:name].nil? || params[:registro][:fname].nil? || params[:registro][:email].nil? || params[:registro][:password].nil? || params[:registro][:phone].nil? || params[:registro][:address].nil?

puts "if****************************************************" 
	

puts @appuser = Appuser.new(
name: params[:registro][:name],
fname: params[:registro][:fname], 
email: params[:registro][:email], 
password: params[:registro][:password], 
phone: params[:registro][:phone], 
address: params[:registro][:address] )

	if @appuser.save 
	#flash[:success] = "Welcome to your profile page!"

		redirect '/pcard'
	else
	#	"Sorry, there was an error!"
 	#	render 'new'
    
	end
	
end #unless
@registrado='<h1>Sea registrado correctamente</h1>
<p><a href="/"Volver al inicio</a></p>'
erb :registarse
end

get '/viaje' do


erb :viaje
end

get '/wompi' do
erb :wompi
end

get '/login' do
erb :login
end

not_found do
  "Page Not Found"
end




def picture_urls
  Dir.glob('public/pictures/**').map { |path| path.sub('public', '') }
end


