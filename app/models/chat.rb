require 'observer'

class Chat
  include Observable
  include Singleton

  def append_message(message)
    if message.save
      Rails.logger.debug "Notify #{count_observers} observers"
      changed
      notify_observers('append_message', message)
      true
    else
      false
    end
  end

end