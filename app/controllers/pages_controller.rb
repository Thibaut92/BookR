class PagesController < ApplicationController
  include Devise::Controllers::Helpers
  skip_before_action :authenticate_user!, only: [:home]
  
  def home
  end
end
