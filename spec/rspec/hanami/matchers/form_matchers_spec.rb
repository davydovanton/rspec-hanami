require 'spec_helper'
require 'rspec/hanami/matchers'

RSpec.describe 'form matchers' do
  include RSpec::Hanami::Matchers

  let(:view) { MainView.new }

  describe '#have_action' do
    context 'for form with right action' do
      it 'return true' do
        expect(view.form).to have_action('/users')
      end
    end

    context 'for form with other action' do
      it 'return false' do
        expect(view.form).to_not have_action('/books')
      end
    end
  end

  describe '#have_method' do
    context 'for form with right method' do
      it 'return true' do
        expect(view.form).to have_method('POST')
        expect(view.form).to have_method(:post)
      end
    end

    context 'for form with other method' do
      it 'return false' do
        expect(view.form).to_not have_method('PUT')
        expect(view.form).to_not have_method(:put)
      end
    end
  end
end
