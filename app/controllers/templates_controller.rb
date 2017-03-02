class TemplatesController < ApplicationController
  before_action :set_card, only: [:show, :update, :destroy]

  # GET /templates
  # GET /templates.json
  def index
    @templates = Template.all
  end
end
