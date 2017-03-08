class TemplatesController < ApplicationController
  before_action :set_card, only: [:show, :update, :destroy]

  # GET /templates
  # GET /templates.json
  def index
    @base_url = "#{root_url}/images/cards-templates"
    @templates = Template.all
  end
end
