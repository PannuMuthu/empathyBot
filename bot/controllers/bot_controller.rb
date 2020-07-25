class BotController < Stealth::Controller
  
  def route
    if current_message.payload.present?
      handle_payloads
      current_message.payload = nil
      return
    end
    
    if current_session.present?
      step_to session: current_session
    else
      step_to flow: 'hello', state: 'say_hello'
    end
    
  end
  
  private
  
    def handle_payloads
      payload = current_message.payload
      if payload == 'new_user' || payload == 'developer_restart'
        step_to flow: 'hello', state: 'say_hello'
      elsif payload == 'restart pressed'
        step_to flow: 'goodbye', state: 'say_hello_again'
      else
        return
      end
    end
    
end
