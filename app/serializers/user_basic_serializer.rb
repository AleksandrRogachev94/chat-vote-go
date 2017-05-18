class UserBasicSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :avatar_url

  def avatar_url
    ActionController::Base.helpers.asset_url(object.avatar.url(:thumb))
  end
end
