class StaticPagesController < ApplicationController
  def home
  	@title = "Home"
  end

  def help
  	@title = "Help"
  	@temp = "test1"
  	@temp2 = "test2"
  end

  def about
  	@title = "About"
  end

  def contact
  	@title = "Contact"
  end
end
