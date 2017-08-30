module ApplicationHelper

  def page_title
    if content_for? :title
      "Movies - #{content_for :title}"
    else
      "Movies"
    end
  end

  def title(object)
    content_for(:title, object)
  end

end
