class ChatsController < ApplicationController
  include ActionController::Live

  def connect
    response.headers['Content-Type'] = 'text/event-stream'
    @sse = SSE.new(response.stream)
    Chat.instance.add_observer(self)
    # 10 minutes
    60.times do
      if response.stream.closed?
        Rails.logger.info "Stopping cause stream was closed"
        break
      else
        @sse.write 'ping'
      end
      sleep 10
    end

  rescue IOError
    Rails.logger.info "Closing stream on send error"
  ensure
    Chat.instance.delete_observer(self)
    @sse.close
  end

  # called by chat observable
  def update(action, entity)
    begin
      @sse.write entity.as_json, id: entity.id, event: action
    rescue IOError
      Rails.logger.info "Closing stream on send error"
      @sse.close
    end
  end

end
