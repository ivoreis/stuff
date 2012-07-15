class ActionsController < ApplicationController

  def follow
    @member = Person.find(params[:id])
    current_person.follow(@member)
  end

  def unfollow
    @member = Person.find(params[:id])
    current_person.unfollow(@member)
  end

  def tag
    @model = params[:payload][:type].constantize.send(:find, params[:payload][:id])
    current_person.tag(@model, :with=>params[:payload][:value], :on => :tags)
  end

  def vote
    @model = params[:type].constantize.send(:find, params[:id])
    current_person.voted_on?(@model) ?  current_person.remove_vote(@model)  : current_person.like(@model)
  end

  def favorite

  end

  def comment
    payload = params[:payload]
    @model = payload[:type].constantize.send(:find, payload[:id])
    @model.add_comment current_person, payload[:value]
  end


end