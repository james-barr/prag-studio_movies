require "rails_helper"

describe "Confirming presence of footer" do
  def confirm_footer
    expect(page).to have_selector("footer")
  end

  def confirm_header
    expect(page).to have_selector("header")
  end

  def confirm_aside
    expect(page).to have_selector("aside")
  end

  it "checks the index page" do
    visit movies_url

    confirm_footer
    confirm_header
    confirm_footer
  end

  it "checks the new page" do
    visit new_movie_url

    confirm_footer
    confirm_header
    confirm_footer
  end

end
