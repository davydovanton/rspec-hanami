require 'spec_helper'
require 'rspec/hanami/matchers'

RSpec.describe 'match_entity_schema' do
  include RSpec::Hanami::Matchers

  let(:entity) { UserEntity.new(id: 1, name: 'whatever', gender: true) }

  describe 'pass with success' do
    context 'for UserEntity single parameter' do
      it { expect(entity).to have_attribute(:name, Types::String) }
    end

    context 'for UserEntity multiple parameters' do
      it { expect(entity).to have_attributes(id: Types::Int, name: Types::String, gender: Types::Bool) }
    end
  end

  describe 'pass with failure' do
    context 'for UserEntity single parameter' do
      it { expect(entity).not_to have_attribute(:name, Types::Int) }
    end

    context 'for UserEntity multiple parameters' do
      it { expect(entity).not_to have_attributes(id: Types::Int, name: Types::Int,  gender: Types::Bool) }
    end
  end
end
