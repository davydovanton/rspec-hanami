require 'spec_helper'

RSpec.describe 'form matchers', type: :request do
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

  describe '#have_field' do
    context 'for form with right field' do
      it 'return true' do
        expect(view.form).to have_field(node: 'input', type: 'text', id: 'user-first-name')
      end
    end

    context 'for form with invalid field' do
      it 'return false' do
        expect(view.form).to_not have_field(node: 'input', type: 'hidden', value: '100')
      end
    end
  end
end
