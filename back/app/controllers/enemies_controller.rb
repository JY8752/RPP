class EnemiesController < ApplicationController

  # GET /enemies/1
  def show
    enemy = Enemy.find_by(stage_level: params[:stage_id])
    render json: enemy.get_enemy
  end
end
