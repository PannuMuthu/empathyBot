class GoodbyesController < BotController
  
  def say_goodbye
    send_replies
    step_to state: 'ask_restart'
  end
  
  def ask_restart
    send_replies
    update_session_to state: 'get_restart'
  end
  
  def get_restart
    if @payload == 'restart pressed'
      step_to state: 'say_hello_again'
    else
      send_replies
      update_session_to state: 'get_restart'
    end
  end
  
  def say_hello_again
    send_replies
    step_to flow: 'hello', state: 'ask_feeling'
  end
  
end

