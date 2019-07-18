module MicropostsHelper
  def gravatar_url(micropost, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(micropost.email.downcase)
    size = options[:size]
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
end
