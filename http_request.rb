class HttpRequest
  def initialize(request)
    @request = request
  end

  def request
    method, path, version = @request.lines[0].split

    {
      method: method,
      path: path,
      headers: parse_headers(@request)
    }
  end

  private

  def normalize(header)
    header.gsub(':', '').downcase.to_sym
  end

  def parse_headers(request)
    headers = {}

    request.lines[1..-1].each do |line|
      return headers if line == "\r\n"

      header, value = line.split
      header = normalize(header)
      headers[header] = value
    end
  end
end
