class GamesController < ApplicationController

  swagger_controller :games, "Game Management"

  swagger_api :index do
    summary "Fetches all game objects"
    notes "This lists all the games"
  end

  swagger_api :show do
    summary "Shows one Game object"
    param :url, :id, :integer, :required, "Game ID"
    notes "This lists details of one game"
    response :not_found
  end

  swagger_api :create do
    summary "Create a new game"
    param :form, :name, :string, :required, "Name"
    param :form, :date, :date, :required, "Date"
    param :form, :time, :time, :required, "Time"
    param :form, :description, :text, :optional, "Description"
    param :form, :private, :boolean, :required, "Private"
    param :form, :latitude, :float, :required, "Latitude"
    param :form, :longitude, :float, :required, "Longitude"
    response :not_acceptable
  end

  swagger_api :update do
    summary "Create a new game"
    param :form, :name, :string, :required, "Name"
    param :form, :date, :date, :required, "Date"
    param :form, :time, :time, :required, "Time"
    param :form, :description, :text, :optional, "Description"
    param :form, :private, :boolean, :required, "Private"
    param :form, :latitude, :float, :required, "Latitude"
    param :form, :longitude, :float, :required, "Longitude"
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Game"
    param :path, :id, :integer, :required, "Game ID"
    response :not_found
    response :not_acceptable
  end

  before action :set_game, only: [:show, :update]

  def index
    @games = Game.all
    render json: @games
  end

  def show
    render json: @game
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      render json: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  def update
    if @game.update(game_params)
      render json: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  private
  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.permit(:name, :date, :time, :description, :private, :latitude, :longitude)
  end

end