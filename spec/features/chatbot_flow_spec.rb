require "spec_helper"

describe "chatbot flow" do
  include Rack::Test::Methods

  let!(:message) { 
    SampleMessage.new(
      service: "facebook"
    )
  }

  def app
    Stealth::Server
  end

  let(:client) { Stealth::Services::Facebook::Client }

  it "handles user conversation" do
    Sidekiq::Testing.inline! do
      expect(client).to receive_message(
        message.message_with_text("hello")
      )
        .as_service("facebook")
        .and_send_replies([
          {
            "recipient" => {
              "id" => message.sender_id
            },
            "message" => {
              "text" => "Hello World!"
            }
          },
          {
            "recipient" => {
              "id" => message.sender_id
            },
            "message" => {
              "text" => "Goodbye World!"
            }
          }
        ])
    end
  end
end
