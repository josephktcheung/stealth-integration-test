class HellosController < BotController

  def say_hello
    send_replies
    step_to flow: "goodbye"
  end

end
