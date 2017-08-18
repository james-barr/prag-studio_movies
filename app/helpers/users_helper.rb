module UsersHelper

  def present_user_created(object)
    object.created_at.strftime("%B %d, %Y")
  end

  def gravatar_image(object)
    hash = Digest::MD5.hexdigest object.email
    url = "https://www.gravatar.com/avatar/#{hash}"
  end

end
