module MembersHelper

  # TODO fix this, find a way to use the url helpers and link_to inside helpers/models

  def content_for_activity activity
    act, model, action = activity.key.split('.')
    I18n.t("#{activity.key}", owner: owner_link(activity.owner), traceable: traceable_link(model, activity.traceable)).html_safe
  end

  def put_name entry
    name = entry.owner.name
    name += " > " + entry.timeline.owner.name  unless  entry.owner === entry.timeline.owner
    name
  end

  private

    def traceable_link model, traceable
      return simple_link traceable.title, "/forum/#{traceable.room.slug}/topics/#{traceable.slug}" if model == 'topic'
      return simple_link traceable.receiver.name, "/members/view/#{traceable.receiver.slug}" if model == 'followship'
      return simple_link traceable.commentable.title, "/forum/#{traceable.commentable.room.slug}/topics/#{traceable.commentable.slug}" if model == 'comment'
      ""
    end

    def owner_link owner
      simple_link owner.name, "/members/view/#{owner.slug}"
    end

    def simple_link text, href
      "<a href='#{href}'>#{text}</a>"
    end

end