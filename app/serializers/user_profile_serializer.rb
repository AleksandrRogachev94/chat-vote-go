class UserProfileSerializer < ActiveModel::Serializer
  attributes :id, :email, :nickname, :first_name, :last_name, :created_at, :avatar_original_url, :avatar_thumb_url

  def avatar_original_url
    ActionController::Base.helpers.asset_url(object.avatar.url(:original))
  end

  def avatar_thumb_url
    ActionController::Base.helpers.asset_url(object.avatar.url(:thumb))
  end

  def created_at
    object.created_at.to_f * 1000 # convert to milliseconds since 1970-01-01 00:00:00 UTC.
  end
end
