class InterfaceController < ApplicationController
  def index
    @books = Book.where(user_id: nil).where.not(id: Provide.where(user_id: current_user).pluck(:book_id))
  end
end
