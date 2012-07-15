class MembersController < ApplicationController
  respond_to :html, :json, :xml, :js

  def list
    @people = search params[:q]
    respond_with @people
  end

  def comment
    @member= Person.find(params[:id])
    @entry = @member.create_timeline_entry current_person, params[:body], params[:attachment]
    if @entry.save
    end
    return redirect_to profile_path if @member == current_person
    redirect_to member_view_path(@member)
  end

  def view
    klass = Person
    klass = params[:type].constantize.classify if(params[:type]).present?
    @member = klass.find(params[:id])
    @profile_entries = @member.timeline.entries
    @timeline_entry = @member.timeline.entries.build
  end

  def all
    @members = Person.page(params[:page])
  end

end