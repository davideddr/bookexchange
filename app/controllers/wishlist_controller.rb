class WishlistController < ApplicationController
  def insert
    book = Book.find(params[:book_id])
    @wishlist = Wishlist.create
    @wishlist.book = book
    @wishlist.user = current_user
    ris = Wishlist.where(book_id: book, user_id: current_user).exists?
    if !ris
      if @wishlist.save
        redirect_to :root, notice: _('Book was successfully insert in the wishlist.')
      else
        redirect_to :root, alert: _('Book wasn\'t insert in the wishlist.')
      end
    else
      redirect_to :root, alert: _('Book already in the wishlist.')
    end
  end

  def remove
    book = Book.find(params[:bo_id])
    @wishlist = Wishlist.where(book_id: book, user_id: current_user).first
    @wishlist.destroy
    respond_to do |format|
      format.html { redirect_to books_requests_path, notice: _('Remove from the wishlist') }
      format.json { head :no_content }
    end
  end
end
