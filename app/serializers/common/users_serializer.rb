# frozen_string_literal: true

module Common
  class UsersSerializer < ActiveModel::Serializer
    attributes :users

    delegate to: :object

    def users
      object.users.each_with_object([]) do |user, arr|
        arr << Common::UserSerializer.new(user)
      end
    end
  end
end
