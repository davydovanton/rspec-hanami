require 'hanami/model'

class UserEntity < Hanami::Entity
  attributes do
    attribute :id,     Types::Int
    attribute :name,   Types::String
    attribute :gender, Types::Bool
  end
end
