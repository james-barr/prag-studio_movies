module UsersHelper

  def present_user_created(object)
    object.created_at.strftime("%B %d, %Y")
  end

  def gravatar_image(object, options = {})
    size = options[:size] || 80
    url = "https://www.gravatar.com/avatar/#{object.gravatar_id}"
    image_tag url, alt: object.name, size: size
  end

end
