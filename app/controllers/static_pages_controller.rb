class StaticPagesController < ApplicationController
  def home
    @entries = current_user.entries.build if logged_in?
  end

  def about
  end

  def contact
  end

  def help
  end
end
