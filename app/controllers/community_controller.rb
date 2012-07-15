class CommunityController < ApplicationController
  def index
    @members = Person.page(params[:page])
  end
end