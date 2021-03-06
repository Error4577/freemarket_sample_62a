class SignupController < ApplicationController
  def index
  end

  def registration
    @user = User.new
  end

  def registration_validates
    # binding.pry
    # sessionにとりあえず格納
    if verify_recaptcha
      session[:nickname] = user_params[:nickname]
      session[:email] = user_params[:email]
      session[:password] = user_params[:password] if session[:password] == nil
      session[:date_of_birth] = Date.new(
        user_params["date_of_birth(1i)"].to_i,
        user_params["date_of_birth(2i)"].to_i,
        user_params["date_of_birth(3i)"].to_i)
      session[:last_name] = user_params[:last_name]
      session[:first_name] = user_params[:first_name]
      session[:last_name_kana] = user_params[:last_name_kana]
      session[:first_name_kana] = user_params[:first_name_kana]
  
      # バリデーション用のインスタンスを準備
      @user = User.new(
        nickname: session[:nickname],
        email: session[:email],
        password: session[:password],
        last_name: session[:last_name],
        first_name: session[:first_name],
        last_name_kana: session[:last_name_kana],
        first_name_kana: session[:first_name_kana],
        date_of_birth: session[:date_of_birth],
        phone_number: "0000000000"        # 仮のphone_numberを代入
      )
      # binding.pry
      # @user.valid?がtrueを返せば次のページに進む。falseを返せば同じページをレンダーする。
      if @user.valid?
        @user.phone_number = nil          # 仮のphone_numberをリセット
        redirect_to sms_authentication_signup_index_path
      else
        render 'signup/registration'
      end
    else
      @user = User.new(
        nickname: session[:nickname],
        email: session[:email],
        password: session[:password],
        last_name: session[:last_name],
        first_name: session[:first_name],
        last_name_kana: session[:last_name_kana],
        first_name_kana: session[:first_name_kana],
        date_of_birth: session[:date_of_birth]
      )
      render 'signup/registration'
    end
  end

  def sms_authentication
    @user = User.new
  end

  def sms_authentication_validates
    session[:phone_number] = user_params[:phone_number]

    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      last_name: session[:last_name],
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana],
      date_of_birth: session[:date_of_birth],
      phone_number: session[:phone_number]
    )

    if @user.valid?
      redirect_to sms_confirmation_signup_index_path
    else
      render 'signup/sms_authentication'
    end
  end

  def sms_confirmation
  end

  def sms_confirmation_validates
    redirect_to address_signup_index_path
  end

  def address
    @address = Address.new
  end

  def address_validates
    session[:address_last_name] = address_params[:last_name]
    session[:address_first_name] = address_params[:first_name]
    session[:address_last_name_kana] = address_params[:last_name_kana]
    session[:address_first_name_kana] = address_params[:first_name_kana]
    session[:address_postal_code] = address_params[:postal_code]
    session[:address_prefecture] = address_params[:prefecture]
    session[:address_city_name] = address_params[:city_name]
    session[:address_block_number] = address_params[:block_number]
    session[:address_building_name] = address_params[:building_name]
    session[:address_phone_number] = address_params[:phone_number]
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      last_name: session[:last_name],
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana],
      date_of_birth: session[:date_of_birth],
      phone_number: session[:phone_number]
    )
    @address = Address.new(
      user: @user,
      last_name: session[:address_last_name],
      first_name: session[:address_first_name],
      last_name_kana: session[:address_last_name_kana],
      first_name_kana: session[:address_first_name_kana],
      postal_code: session[:address_postal_code],
      prefecture: session[:address_prefecture],
      city_name: session[:address_city_name],
      block_number: session[:address_block_number],
      building_name: session[:address_building_name],
      phone_number: session[:address_phone_number]
    )
    if @address.valid?
      redirect_to creditcard_signup_index_path
    else
      render 'signup/address'
    end
  end

  def creditcard
    @card = Card.new
  end

  def creditcard_validates
    Payjp.api_key = Rails.application.credentials.payjp[:private_key]
    if params['payjp-token'].blank?
      redirect_to action: "creditcard"
    else
      customer = Payjp::Customer.create(
        description: '登録テスト',
        email: "test@test.com",
        card: params['payjp-token']
      )
      session[:customer_id] = customer.id
      session[:card_id] = customer.default_card
      redirect_to done_signup_index_path
    end
  end

  def done
    @user = User.create(
      nickname:         session[:nickname],
      password:         session[:password],
      email:            session[:email],
      date_of_birth:    session[:date_of_birth],
      last_name:        session[:last_name],
      first_name:       session[:first_name],
      last_name_kana:   session[:last_name_kana],
      first_name_kana:  session[:first_name_kana],
      phone_number:     session[:phone_number],
      provider:         session[:provider],
      uid:              session[:uid]
    )
    @address = Address.create(
      user:             @user,
      last_name:        session[:address_last_name],
      first_name:       session[:address_first_name],
      last_name_kana:   session[:address_last_name_kana],
      first_name_kana:  session[:address_first_name_kana],
      postal_code:      session[:address_postal_code],
      prefecture:       session[:address_prefecture],
      city_name:        session[:address_city_name],
      block_number:     session[:address_block_number],
      building_name:    session[:address_building_name],
      phone_number:     session[:address_phone_number]
    )
    @card = Card.create(
      user:             @user,
      customer_id:      session[:customer_id],
      card_id:          session[:card_id]
    )
    session.clear
    sign_in(@user)
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :last_name, :first_name, :last_name_kana, :first_name_kana, :date_of_birth, :phone_number)
  end

  def address_params
    params.require(:address).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :prefecture, :city_name, :block_number, :building_name, :phone_number)
  end

  def creditcard_params
    params.require(:card).permit(:payment_card_no, :payment_card_security_code, :expiration_date)
  end
end
