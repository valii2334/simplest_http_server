class HttpResponse

  SERVER_ROOT_PATH = __dir__ + '/'
  INDEX_PATH = SERVER_ROOT_PATH + "index.html"
  NOT_FOUND_PATH = SERVER_ROOT_PATH + "404.html"

  def initialize(request)
    @request = request
  end

  def response
    path = @request.fetch(:path)

    if path == "/"
      respond_with(INDEX_PATH)
    else
      respond_with(SERVER_ROOT_PATH + path)
    end
  end

  private

  def respond_with(path)
    if File.exists?(path)
      respond(code: 200, body: File.binread(path))
    else
      respond(code: 200, body: File.binread(NOT_FOUND_PATH))
    end
  end

  def respond(code: , body: '')
    "HTTP/1.1 #{code}\r\n" +
    "Content-Length: #{body.size}\r\n" +
    "\r\n" +
    "#{body}\r\n"
  end
end
