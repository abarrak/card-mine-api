module Overrides
  class ConfirmationsController < DeviseTokenAuth::ConfirmationsController
    def show
      @resource = resource_class.confirm_by_token(params[:confirmation_token])

      if @resource && @resource.id
        @resource.confirm
        @resource.save!

        yield @resource if block_given?

        redirect_to secure_url(params[:redirect_url])
      else
        raise ActionController::RoutingError.new('Not Found')
      end
    end

    private

      def secure_url url
        parsed_url = URI.parse url
        parsed_url.host == URI.parse(root_url).host ? parsed_url : root_url
      end
  end
end
