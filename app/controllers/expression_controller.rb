class ExpressionController < ApplicationController
  respond_to :xml, :html, :json

  def index
    @items = ExpressionItem.page(params[:page])
    respond_with @items
  end

  def new
    @item = ExpressionItem.new
    respond_with @item
  end

  def show
    @item = ExpressionItem.find(params[:id])
    respond_with @item
  end

  def edit
    @item = ExpressionItem.find(params[:id])
    respond_with @item
  end

  def create
    @item = ExpressionItem.new(params[:item])
    @item.owner = current_person
    if @item.save
      flash[:notice] = "Successfully created item."
    end
    redirect_to expression_index_path
  end

  def destroy

  end

  def update

  end
end