RSpec::Matchers.define :receive_message do |message|
  match do |client|
    stub = double("client")
    allow(stub).to receive(:transmit).and_return(true)
    @replies.each do |reply|
      expect(client).to receive(:new)
        .with(hash_including(reply: hash_including(reply)))
        .ordered
        .and_return(stub)
    end

    json = message.to_request_json
    post "/incoming/#{@service}", json, { "CONTENT_TYPE" => "application/json" }
  end

  chain :as_service do |service|
    @service = service
  end
  
  chain :and_send_replies do |replies|
    @replies = replies
  end
end
