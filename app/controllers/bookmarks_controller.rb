class BookmarksController < ApplicationController

  def create
    bookmark = Bookmark.new(bookmark_params)
    bookmark.list_id = params[:list_id]
    if bookmark.save
      redirect_to list_path(bookmark.list.id)
    else
      redirect_to list_path(bookmark.list), status: :unprocessable_entity
    end
  end

  def destroy
    list = Bookmark.find(params[:id]).list
    Bookmark.destroy(params[:id])

    redirect_to list_path(list), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
