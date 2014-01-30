module Hydramata::Deposit
  class ApplicationController < ActionController::Base
    class_attribute :theme
    self.theme = Hydramata.configuration.layout.theme
    helper_method :theme
  end
end
