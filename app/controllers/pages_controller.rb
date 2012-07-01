class PagesController < ApplicationController
  def show
    @page = Page.find_by_permalink(params[:id])
    if !@page
    	@page = Page.new
    	@page.permalink = params[:id]
    	@page.save
    end
  end
end