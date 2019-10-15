class SampleMessage

  def initialize(service:)
    @service = service
    @base_message = Stealth::ServiceMessage.new(service: @service)
    @base_message.sender_id = sender_id
    @base_message.timestamp = timestamp
    @base_message
  end

  def message_with_text
    @base_message.message = message
    self
  end

  def message_with_payload
    @base_message.payload = payload
    @base_message
  end

  def message_with_location
    @base_message.location = location
    @base_message
  end

  def message_with_attachments
    @base_message.attachments = attachments
    @base_message
  end

  def sender_id
    if @service == 'twilio'
      '+15554561212'
    else
      "8b3e0a3c-62f1-401e-8b0f-615c9d256b1f"
    end
  end

  def timestamp
    Time.now
  end

  def message
    "Hello World!"
  end

  def payload
    "some_payload"
  end

  def location
    { lat: '42.323724' , lng: '-83.047543' }
  end

  def attachments
    [ { type: 'image', url: 'https://domain.none/image.jpg' } ]
  end

  def referral
    {}
  end

  def to_request_json
    if @base_message.message.present?
      JSON.generate({
        entry: [
          {
            "messaging": [
              "sender": {
                "id": @base_message.sender_id
              },
              "recipient": {
                "id": "<PAGE_ID>"
              },
              "timestamp": @base_message.timestamp.to_i * 1000,
              "message": {
                "mid":"mid.1457764197618:41d102a3e1ae206a38",
                "text": @base_message.message
              }
            ]
          }
        ]
      })
    end
  end
end