# /bot/controllers/hellos_controller.rb

class HellosController < BotController
  
  def say_hello
    @profile = get_profile
    send_replies
    step_to state: 'ask_feeling'
  end
  
  def ask_feeling
    send_replies
    update_session_to state: 'get_feeling'
  end
  
  def get_feeling
    send_replies
    
    if current_message.message == 'Sad'
      step_to state: 'say_boo'
    elsif current_message.message == 'Happy'
      step_to state: 'say_wow'
    elsif current_message.message == 'Angry'
      step_to state: 'say_calm'
    else
      step_to state: 'ask_feeling'
    end
  end
  
  def say_wow
    send_replies
    step_to flow: 'goodbye', state: 'say_goodbye'
  end
  
  def say_boo
    send_replies
    step_to flow: 'goodbye', state: 'say_goodbye'
  end

  def say_calm
    send_replies
    step_to flow: 'goodbye', state: 'say_goodbye'
  end

  private
  
  def get_profile
    fb_profile = Stealth::Services::Facebook::Client.fetch_profile(recipient_id: current_user_id)
    return fb_profile
  end
  
end

