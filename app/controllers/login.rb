get '/login' do
	erb :'auth/login'
end

post '/login' do
	@user = User.find_by(name: params[:user]["name"]).try(:authenticate, params[:user]["password"])

	if @user
      session[:user_id] = @user.id
  		redirect "/users/#{@user.id}"
    else
      redirect '/login'
    end
end

get '/signup' do
	erb :'auth/signup'
end

get '/logout' do
	session.delete(:user_id)
	redirect '/'
end

post '/signup' do
  hashed_password = BCrypt::Password.create(params[:password])
	user = User.create!(name: params[:name], password_digest: hashed_password)
  redirect "/users/#{user.id}"
end

