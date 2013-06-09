class ExtrasController < ApplicationController
  respond_to :html, :pdf

  def about_me

  end

  def resume
    send_file("public/Erin_Drummond_resume.pdf", :type => 'application/pdf', :disposition => 'inline')
  end

  def portfolio

  end

end