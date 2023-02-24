class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @bookmark = Bookmark.new
    @list = List.find(params[:id])
  end
end
