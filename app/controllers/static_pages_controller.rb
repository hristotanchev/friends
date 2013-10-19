class StaticPagesController < ApplicationController
  def home
  end

  def help
  @user = 'Test IOS'
    respond_to do |format|
      format.json { render json: @user }
    end
  end

  def aboute
  end

  def contact
  end
end
