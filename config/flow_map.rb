class FlowMap

  include Stealth::Flow

  flow :hello do
    state :say_hello
    state :ask_name
    state :get_name, fails_to: :ask_name
    state :say_greeting
  end

  flow :goodbye do
    state :say_goodbye
  end

  flow :catch_all do
    state :level1
  end

end
