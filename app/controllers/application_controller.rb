class ApplicationController < Sinatra::Base
  set :default_content_type, "application/json"

  configure do
    enable :cross_origin
  end

  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  options "*" do
    response.headers["Access-Control-Allow-Methods"] = "GET, PATCH, PUT, POST, DELETE"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end


  # get '/hello' do
  #   "hello my brother"
  # end

  # CRUD OPERATIONS FOR USERS

  # user sign in
  patch "/login" do
    user = User.find_by(name: params[:name], password: params[:password])
    if !!user
    { isRegistered: "#{!!user}", user: user }.to_json
    else
      { isRegistered: "#{!!user}", user: user}.to_json
    end
  end

  # user sign up
  post "/signup" do
    is_signed_up = User.find_by(email: params[:email])
    if is_signed_up
      { isAlreadyRegistered: "#{!!is_signed_up}" }.to_json
    else
      user = User.create(name: params[:name], email: params[:email], password: params[:password])
      { isAlreadyRegistered: "#{!!is_signed_up}", user: user }.to_json
    end
  end

  # GET all users
  get '/users' do
    users = User.all
    # erb :users_index
    users.to_json
  end

  # route to update a specific user by id
  put '/users/:id' do
    # retrieve a user with a specific id from database
    user = User.find(params[:id])
    if user.update(params)
      # send a response indicating successful update of the user
      user.to_json
    else
      # send an error response if update fails
      status 400
      { error: "Could not update user" }.to_json
    end
  end
  
  # DELETE a user
  delete '/users/:id' do
    user = User.find(params[:id])
    user.destroy
    { deletedUser: user}.to_json
  end

  # user create todo
  post "/todos/create" do
    # create a new todo object with parameters from request
    todo = Todo.new(params)
    if todo.save
      # send a response indicating successful creation of a new todo
      status 201
      todo.to_json
    else
      # send an error response if todo creation fails
      status 400
      { error: "Could not create a todo" }.to_json
    end
  end

   # user updates todo
  patch "/todos/update/:id" do
    todo = Todo.find(params[:id])
    todo.update(status: params[:status])
    todo.to_json
  end

   # user gets individual todo
  get "/todos/:id" do
    todo = Todo.find(params[:id])
    todo.to_json
  end

   # user lists all their own todo
  get "/todos/user/:id" do
    todo = Todo.where(user_id: params[:id])
    todo.to_json
  end
  
   # user delete specific todos
  delete "/todos/:id" do
    todo = Todo.find(params[:id])
    todo.destroy
    todo.to_json
  end

end
