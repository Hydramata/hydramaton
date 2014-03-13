class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  class_attribute :theme
  self.theme = Hydramata.configuration.layout.theme
  helper_method :theme

  def services
    @services ||= HydramataServices.new
  end
end
