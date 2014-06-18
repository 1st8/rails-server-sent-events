class MessagesController < ApplicationController

  def create
    message = Message.new(message_params.merge(author: request.remote_ip.split('.').last))
    if Chat.instance.append_message(message)
      render nothing: true, status: 201
    else
      render nothing: true, status: 400
    end
  end

  private

  def message_params
    params.require(:message).permit(:text)
  end

end
