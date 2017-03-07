class TextualContentController < ApplicationController
  before_action :authenticate_user!
  before_action :set_card
  before_action :authorize_for_card!
  before_action :set_textual_content, only: [:show, :update, :destroy]

  # GET /cards/:card_id/textual_content
  # GET /cards/:card_id/textual_content.json
  def index
    @all_textual_content = @card.textual_content
  end

  # GET /cards/:card_id/textual_content/:id
  # GET /cards/:card_id/textual_content/:id.json
  def show
  end

  # POST /cards/:card_id/textual_content
  # POST /cards/:card_id/textual_content.json
  def create
    @textual_content = @card.textual_content.build textual_content_params

    if @textual_content.save
      render :show, status: :created, location: [@card, @textual_content]
    else
      render json: @textual_content.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cards/:card_id/textual_content/:id
  # PATCH/PUT /cards/:card_id/textual_content/:id.json
  def update
    if @textual_content.update textual_content_params
      render :show, status: :ok, location: [@card, @textual_content]
    else
      render json: @textual_content.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cards/:card_id/textual_content/:id
  # DELETE /cards/:card_id/textual_content/:id.json
  def destroy
    if @textual_content.destroy
      render json: { message: 'Textual content deleted sucussfully.' }, status: 200
    else
      render json: { message: 'Failed to delete textual content.' }, status: :unprocessable_entity
    end
  end

  private

    def set_card
      @card = Card.find params[:card_id]
    end

    def set_textual_content
      @textual_content = TextualContent.find params[:id]
      @card = @textual_content.card
    end

    def textual_content_params
      params.require(:textual_content).permit :content, :font_family, :font_size, :color,
                                              :x_position, :y_position, :width, :height
    end

    def authorize_for_card!
      unauthorized_response && return unless authorized_for? @card
    end
end
