require 'sinatra'
require 'net/http'
require 'json'



get '/' do  
	'
	<form action="/" method="post">
	Ton facebook "username": <input type="text" name="username" />
	nombre de vote <input type="number" name="nvotes" min="0" max="50"/>
	<button type="submit" />
	</form>
	'
end



post '/' do

	nvotes=params[:nvotes].to_i
	if nvotes > 50
		return "bara nayk"
	end

	noob = params[:username]
	rname = Net::HTTP.get("graph.facebook.com", "/#{noob}?fields=name")
	name = JSON.parse(rname)['name']

	payload = {"url" => "https://www.facebook.com/" + noob ,
		"name" => name,
		"hashtags" => ["#geek"],
		"imguri" => "http://graph.facebook.com/"+noob+"/picture?type=normal",
		"count" => "1"}

	
	nvotes.times do |i|
		x = Net::HTTP.post_form(URI('http://www.kanalabs.com:8080/wines'), payload)
		puts x.code		
		end

	
	"Vote done pour #{name}"


end