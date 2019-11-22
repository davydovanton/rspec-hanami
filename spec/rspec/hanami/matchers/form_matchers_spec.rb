require 'spec_helper'

RSpec.describe 'form matchers', type: :request do
  let(:view) { MainView.new }

  describe '#have_form_action' do
    context 'for form with right action' do
      it 'return true' do
        expect(view.form).to have_form_action('/users')
      end
    end

    context 'for form with other action' do
      it 'return false' do
        expect(view.form).to_not have_form_action('/books')
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

  describe '#have_form_field' do
    context 'for form with right field' do
      it 'return true' do
        expect(view.form).to have_form_field(node: 'input', type: 'text', id: 'user-first-name')
      end
    end

    context 'for form with invalid field' do
      it 'return false' do
        expect(view.form).to_not have_form_field(node: 'input', type: 'hidden', value: '100')
      end
    end
  end

  describe 'aliases' do
    it { expect(method(:have_form_action).original_name).to eq(:have_action) }
    it { expect(method(:have_form_method).original_name).to eq(:have_method) }
    it { expect(method(:have_form_field).original_name).to eq(:have_field) }
  end
end
