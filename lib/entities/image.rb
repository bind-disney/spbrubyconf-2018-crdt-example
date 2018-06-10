class Image < Hashie::Dash
  property :link
  property :author
  property :tags
  property :comments_uuids

  def uuid
    SecureRandom.base64
  end
end
