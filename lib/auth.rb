require 'jwt'

class Auth
  ALGORITHM = 'HS256'

  def self.issue(payload, exp_at = 1)
    payload[:exp] = exp_at.minutes.from_now.to_i
    JWT.encode(payload, auth_secret, ALGORITHM)
  end

  def self.decode(token)
    decoded = JWT.decode(token, auth_secret, true, { algorithm: ALGORITHM }).first
    HashWithIndifferentAccess.new(decoded)
  end

  def self.auth_secret
    Rails.application.secrets.secret_key_base
  end
end
