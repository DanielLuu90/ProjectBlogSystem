class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @entry = current_user.entries.build if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def about
  end

  def contact
  end

  def help
  end
end
