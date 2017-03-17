class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_card, only: [:show, :update, :destroy]
  before_action :authorize_for_cards!, except: [:index, :create]

  # GET /cards
  # GET /cards.json
  def index
    @cards = current_user.cards
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = current_user.cards.build card_params

    if @card.save
      render :show, status: :created, location: @card
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    if @card.update card_params
      render :show, status: :ok, location: @card
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.destroy
    render json: { message: 'Card deleted sucussfully.' }, status: 200
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit :title, :description, :user_id, :template_id, :draft,
                                   textual_content_attributes: [:content, :font_family, :font_size,
                                   :color, :x_position, :y_position, :width, :height]
    end

    # Allow access and management for the owner only
    def authorize_for_cards!
      unauthorized_response && return unless authorized_for? @card
    end
end
