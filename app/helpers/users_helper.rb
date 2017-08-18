module UsersHelper

  def present_user_created(object)
    object.created_at.strftime("%B %d, %Y")
  end

  def gravatar_image(object)
    "https://www.gravatar.com/avatar/#{object.gravatar_id}"
  end

end
