class HellosController < BotController

  def say_hello
    send_replies
    step_to state: "ask_name" 
  end

  def ask_name
    send_replies
    update_session_to state: "get_name"
  end

  def get_name
    step_to state: "say_greeting"
  end

  def say_greeting
    @name = current_message.message
    send_replies
    step_to flow: "goodbye"
  end
end
