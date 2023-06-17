class MeetingRequest < Request

  def self.call env
    new.call env
  end

  attr_reader :env, :request, :action, :format

  def call env
    @env = env
    @request = env["LIZA_REQUEST"].to_sym
    @action  = env["LIZA_ACTION"].to_sym
    @format  = env["LIZA_FORMAT"].to_sym

    status = 200
    headers = {
      "Framework" => "Liza #{Lizarb::VERSION}"
    }
    body = render "#{format}.#{format}", "body.#{format}", "#{action}.#{format}"

    log status
    [status, headers, [body]]
  end

end
