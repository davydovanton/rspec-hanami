require 'hanami/controller'
require 'hanami/helpers'
require 'hanami/view'

class MainView
  include Hanami::Helpers::FormHelper

  def params
    {}
  end

  def form
    form_for :user, '/users' do
      input type: 'text', id: 'user-first-name', name: 'user[first_name]', value: 'L'
      check_box :free_shipping
      color_field :cover, name: 'cover'
      date_field :release_date, class: 'form-control'
      email_field :publisher_email
      file_field :image_cover
      hidden_field :author_id, id: 'author-id'
      number_field :percent_read, step: 5
      text_area :description, nil, id: 'desc'
      text_field :title, value: 'DDD'

      submit 'Create'
    end
  end
end
