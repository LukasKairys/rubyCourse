# User controller
class UserController < ApplicationController
  def initialize
    @user_for_creation = []
  end

  def show
    @users = User.all
  end

  def new
  end

  def create
    create_user
    @user_for_creation.save
    redirect_to @user_for_creation
  end

  def create_user
    user_params = read_user_params
    @user_for_creation = User.new(email: user_params[:email],
                     password: user_params[:password])
    assign_company(user_params[:company_name])
  end

  def read_user_params
    params[:user]
  end

  def assign_company(company_name)
    found_company = Company.find_by(name: company_name)
    company = Company.new(name: company_name) unless found_company
    company = found_company if found_company
    @user_for_creation.assign_company(company)
  end
end
