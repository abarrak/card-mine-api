class StaticContentController < ApplicationController
  skip_before_action :resrict_api_access!

  def home
    render json: { status: "success", content: I18n.t('content.home') }
  end

  def about
    render json: { status: "success", content: I18n.t('content.about') }
  end

  def contact
    render json: { status: "success", content: I18n.t('content.contact') }
  end
end
