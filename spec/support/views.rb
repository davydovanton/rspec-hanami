require 'hanami/controller'
require 'hanami/helpers'
require 'hanami/view'

class MainView
  include Hanami::Helpers::FormHelper

  def params
    Hanami::Action::Params.new({})
  end

  def form
    form_for :user, '/users' do
      submit 'Create'
    end
  end
end
