class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  #authorize_resource

  include ApplicationHelper

  def treat_errors
    show_only_error_message $ERROR_INFO
  end

  def search param
    current_person.search param, :sent
  end

  def current_ability
    @current_ability ||= AccountAbility.new(current_person)
  end

end
