class ApplicationController < ActionController::Base
  def cart
    session[:cart] ||= []
  end
end
