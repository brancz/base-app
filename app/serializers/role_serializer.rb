class RoleSerializer < ActiveModel::Serializer
  attributes :id, :name, :internal_name, :users_count
end
