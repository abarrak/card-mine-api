class StaticPagesController < ApplicationController
  before_action :authenticate_user!

  def home
    render json: { status: 'success', data: 'Card mine' }
  end

  def about
    render json: { status: 'success', data: 'Some advertization.' }
  end
end
