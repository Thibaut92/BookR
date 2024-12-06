class UsersController < ApplicationController
  before_action :authenticate_user!

  def search
    query = params[:query].to_s.downcase
    role = params[:role]

    @users = User.where(account_type: role)
                .where("LOWER(company_name) LIKE :query OR 
                       LOWER(business_subcategory) LIKE :query OR 
                       LOWER(company_type) LIKE :query OR 
                       siret LIKE :query", 
                       query: "%#{query}%")
                .limit(10)

    render json: @users.as_json(only: [:id, :company_name, :business_subcategory, :company_type, :siret])
  end
end
