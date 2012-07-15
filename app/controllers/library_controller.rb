class LibraryController < ApplicationController
  respond_to :xml, :html, :json

  def index
   @items = LibraryItem.page(params[:page])
   respond_with @items
  end

  def new
    @item = LibraryItem.new
    respond_with @item
  end

  def show
    @item = LibraryItem.find(params[:id])
    respond_with @item
  end

  def edit
    @item = LibraryItem.find(params[:id])
    respond_with @item
  end

  def create
    @item = LibraryItem.new(params[:item])
    @item.owner = current_person
    if @item.save
      flash[:notice] = "Successfully created item."
    end
    redirect_to library_index_path
  end

  def destroy

  end

  def update

  end

end