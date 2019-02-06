class Client::SessionsController < SessionsController
  def create
    user = User.find_by_username(params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      redirect_to user_path(id: user.id), notice: "Logged in!"
    else
      flash.now[:alert] = "Email or password is invalid"

      render "new"
    end
  end

  def destroy
    session[:user_id] = nil

    redirect_to root_url, notice: "Logged out!"
  end
end