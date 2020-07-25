class FlowMap
  include Stealth::Flow
  
  flow :hello do
    state :say_hello
    state :ask_location, redirects_to: :ask_feeling
    state :ask_feeling
    state :get_feeling, fails_to: :ask_feeling
    state :say_wow
    state :say_boo
    state :say_calm
  end
  
  flow :goodbye do
    state :say_goodbye
    state :ask_restart
    state :get_restart, fails_to: :ask_restart
    state :say_hello_again
  end
  
  flow :catch_all do
    state :level1
  end
  
end
