class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :logined_in_users, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash[:success] = "Micropost Created Successful"
      redirect_to root_url
    else
      # @feed_items = []
      render "static_pages/home"
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    flash[:success] = "Entry Deleted"
    redirect_to request.referrer || root_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:name, :content_entry, :user_id, :integer)
    end
    def correct_user
      @entry = current_user.entries.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
