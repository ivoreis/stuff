class MessagesController < ApplicationController
  def index
    @conversations = current_person.mailbox.conversations
    if params[:view].present?
      conversation = @conversations.find(params[:view] )
      render "messages/conversation/view", locals: {conversation: conversation}
      current_person.mailbox.mark_conversation_as_read conversation
      return
    end
    render "conversations", collection: @conversations
  end

  def notifications
    @notifications = current_person.mailbox.notifications(:except => :Message)
  end

  def compose

  end

  def create
    begin
      @message = treat_message(params)
      mess = {:notice => "Message sent"}
    rescue ActiveRecord::RecordInvalid, Exception
      mess = {:alert => treat_errors}
    end
    if params[:conversation]
      redirect_to messages_path(params.merge({:view=> params[:conversation]})), mess
    else
      redirect_to messages_compose_path, mess
    end
  end
end
