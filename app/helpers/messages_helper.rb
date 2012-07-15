module MessagesHelper
  def get_ids_from string
    Array.wrap(string.split(','))
  end

  def treat_message params
    if params[:conversation]
      reply_message params[:conversation], params[:message]
    else
      new_message params[:message][:receivers], params[:message]
    end
  end

  def new_message receivers, message
    ids = get_ids_from receivers
    current_person.send_message(ids, message[:body],message[:subject])
  end

  def reply_message conversation_id, message
    conversation = Conversation.find(conversation_id)
    conversation.reply(current_person, message[:body], conversation.messages.first.subject,nil)
  end

  def receivers_of conversation
    objects = conversation.receivers.collect(&:name)
    objects.delete(current_person.name)
    objects.join(', ')
  end

end