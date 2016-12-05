require 'hanami-controller'

class SuccessfulAction
  include Hanami::Action

  def call(params)
    self.status  = 200
    self.body    = "Hi! It's successful"
  end
end

class FailedAction
  include Hanami::Action

  def call(params)
    self.status  = 404
    self.body    = "Hi! It's failed"
  end
end

class RedirectedAction
  include Hanami::Action

  def call(params)
    redirect_to 'http://example.com/'
  end
end
