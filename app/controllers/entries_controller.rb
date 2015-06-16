class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit]
  before_action :correct_user,   only: [:destroy, :update]
  def index
    @entries = Entry.all
  end

  def show
    @user = @entry.user
    @comment = @entry.comments.build(user: current_user)
    @comments = @entry.comments.includes(:user)
  end

  def new
    @entry = Entry.new
  end

  def edit
  end

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash[:success] = "Entry Created Successful"
      redirect_to root_url
    else
      @feed_items = []
      render "static_pages/home"
    end
  end

  def update
    if @entry.update(entry_params)
      redirect_to @entry, notice: 'Entry was successfully updated.'
    else
      render :edit 
    end
  end

  def destroy
    if @entry.destroy
      flash[:success] = "Entry Deleted"
    else
      flash[:danger] = "Error!"
    end
    redirect_to request.referrer || root_url
  end

  private
    def set_entry
      @entry = Entry.find(params[:id])
    end

    def entry_params
      params.require(:entry).permit(:name, :content_entry, :user_id, :integer)
    end
    def correct_user
      @entry = current_user.entries.find_by(id: params[:id])
      redirect_to :back unless @entry
    end
end
