require 'hanami/helpers'
require 'hanami/view'

class MainView
  include Hanami::Helpers::FormHelper

  def params
    {}
  end

  def form
    form_for :user, '/users' do
      submit 'Create'
    end
  end
end
