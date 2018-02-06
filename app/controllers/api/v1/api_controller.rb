class Api::V1::ApiController < ApplicationController
  before_action :authenticate_user, only: [:get_data]

  def sign_up
    if params[:email].present? && params[:password].present?
      @user = User.new(user_params)
      if @user.save
        render json: {code: 200, email: @user.email}
      else
        render json: {code: 404, errors: @user.errors.full_messages.join(', ')}
      end
    else
      render json: {code: 404, errors: 'Please provide valid email and password.'}
    end
  end

  def auth
    if params[:email].present?
      @user = User.where(email: params[:email]).first
      if @user.present?
        @user.update(token: Devise.friendly_token)
        render json: {code: 200, token: @user.token}
      else
        render json: {code: 404, errors: 'Email not valid.'}  
      end    
    else
      render json: {code: 404, errors: 'Provide an email.'}
    end
  end

  def get_data
    if params[:text].present?
      data = []
      @authors = Author.full_text_search(params[:text])
      @books = Book.full_text_search(params[:text])
      @reviews = Review.full_text_search(params[:text])
      data << {authors: @authors.pluck(:id, :name)} if @authors.present?
      data << {books: @books.pluck(:id, :name)} if @books.present?
      data << {reviews: @reviews.pluck(:id, :name)} if @reviews.present?
      if data.present?
        render json: {code: 200, data: data}
      else
        render json: {code: 200, message: 'Data not available'}
      end
    else
      render json: {code: 404, errors: 'Provide text'}
    end
  end

  private
  def authenticate_user
    user_token = request.headers['USER-TOKEN']
    if user_token.present?
      @user = User.where(token: user_token).first
      if @user.nil?
        return unauthorize
      end
    else
      return unauthorize
    end
  end

  def unauthorize
    render json: {code: 404, errors: 'Unauthorized.'}
  end

  def user_params
    params.permit(:email, :password)
  end
end
