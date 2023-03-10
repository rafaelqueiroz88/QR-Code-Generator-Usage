class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  protect_from_forgery with: :null_session
  def auth; end

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def authentication
    # id: integer, email: string, password: string,
    # name: string, age: string, is_enabled: string,
    # token: string
    user = User.find_by(email: params[:email])
               .update(is_enabled: true)
    render json: { email: user.email,
                   name: user.name,
                   token: user.token,
                   is_enabled: user.is_enabled }, status: :ok
  end

  # @post /remote_authentication
  # params: email, token
  def remote_authentication
    RemotePermission.create(token: params[:token], is_enabled: 'true')
    render json: { message: 'ok' }, status: :ok
  end

  # @get /remote_ping
  def remote_ping
    # render json: { message: 'Permission not found' }, status: :not_found \
    #   if params[:token].nil?
    permission = RemotePermission.find_by(token: params[:token], is_enabled: 'true')

    if permission.nil?
      render json: { message: 'Permission not found' }, status: :not_found \
    else
      render json: { message: permission.token }, status: :ok
    end
  end

  def qr_code_generator; end

  def qr_code_download
    send_data(RQRCode::QRCode.new(params[:content].to_s).as_png(size: 300),
              type: 'image/png',
              disposition: 'inline')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  # def user_params
  #   params.require(:user).permit(:email, :password, :name, :age)
  # end
end
