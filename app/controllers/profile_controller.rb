class ProfileController < ApplicationController
  respond_to :html

  def index
    @profile = current_person.profile
    @member = current_person
    @followers = @member.received_followships(true).page(params[:page])
    @followees = @member.sent_followships(true).page(params[:page])
    @profile_entries = @member.timeline.entries.reverse!
    @all_entries = @member.followees(true).collect{|f| f.timeline.entries}.flatten + @profile_entries
    @all_entries.sort_by!{|e| e.created_at}.reverse!

  end

  def settings
    @member = current_person
  end

  def update
    @member = current_person
    @member.profile.update_attributes(params[:person_profile])
    redirect_to profile_path
  end

  def crop_update
    @person= current_person
    @person.profile.avatar  = params[:profile][:avatar]
    @person.profile.crop_x = params[:profile]["crop_x"]
    @person.profile.crop_y = params[:profile]["crop_y"]
    @person.profile.crop_h = params[:profile]["crop_h"]
    @person.profile.crop_w = params[:profile]["crop_w"]
    @person.profile.save!
    redirect_to profile_path
  end


end