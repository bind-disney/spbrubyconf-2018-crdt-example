class Comment < Hashie::Dash
  property :text
  property :author

  def uuid
    SecureRandom.base64
  end
end
