class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :created_at, :updated_at, :roles,
    :last_sign_in_at, :failed_attempts

  def filter(keys)
    if scope.has_role? :admin
      keys
    else
      keys - [:last_sign_in_at] - [:failed_attemps]
    end
  end
end
