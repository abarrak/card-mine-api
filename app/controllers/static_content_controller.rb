class StaticContentController < ApplicationController
  skip_before_action :resrict_api_access!

  def home
    render json: { status: "success", content: "Card mine" }
  end

  def about
    render json: { status: "success", content: "Some advertization." }
  end

  def contact
    render json: { status: "success", content: "An email maybe?" }
  end
end
