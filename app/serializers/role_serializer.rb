class RoleSerializer < ActiveModel::Serializer
  attributes :id, :name, :internal_name, :users_count

  def filter(keys)
    if scope.has_role? :admin
      keys
    else
      keys - [:users_count]
    end
  end
end
