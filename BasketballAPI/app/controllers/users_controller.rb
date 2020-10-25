class UsersController < ApplicationController

  swagger_controller :users, "User Management"

  swagger_api :index do
    summary "Fetches all User objects"
    notes "This lists all the users"
  end

  swagger_api :create do
    summary "Creates a new User"
    param :form, :firstname, :string, :required, "First name"
    param :form, :lastname, :string, :required, "Last name"
    param :form, :dob, :date, :required, "Date of Birth"
    param :form, :phone, :string, :required, "Phone number"
    param :form, :email, :string, :required, "Email"
    param :form, :username, :string, :required, "Username"
    param :form, :password, :string, :required, "Password"
    param :form, :password_confirmation, :string, :required, "Password Confirmation"
    response :not_acceptable
  end

  swagger_api :show do
    summary "Shows one User object"
    param :url, :id, :integer, :required, "User ID"
    notes "This lists details of one user"
    response :not_found
  end

  swagger_api :update do
    summary "Updates a new User"
    param :form, :firstname, :string, :required, "First name"
    param :form, :lastname, :string, :required, "Last name"
    param :form, :dob, :date, :required, "Date of Birth"
    param :form, :phone, :string, :required, "Phone number"
    param :form, :email, :string, :required, "Email"
    param :form, :username, :string, :required, "Username"
    param :form, :password, :string, :required, "Password"
    param :form, :password_confirmation, :string, :required, "Password Confirmation"
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing User"
    param :path, :id, :integer, :required, "User ID"
    response :not_found
    response :not_acceptable
  end

  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @user
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    if !@user.destroyed?
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:firstname, :lastname, :email, :username, :dob, :phone, :password, :password_confirmation)
  end
end
