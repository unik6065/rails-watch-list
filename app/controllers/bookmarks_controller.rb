class BookmarksController < ApplicationController

  def create
    bookmark = Bookmark.new(bookmark_params)
    bookmark.list_id = params[:list_id]
    # raise
    if bookmark.save
      redirect_to list_path(bookmark.list.id)
    else
      redirect_to list_path(bookmark.list), status: :unprocessable_entity
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
