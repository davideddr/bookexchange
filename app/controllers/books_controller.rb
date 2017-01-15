class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  autocomplete :book, :title, full: true
  # GET /books
  # GET /books.json
  def index
    @books = Book.joins(:provides).where(provides: { user: current_user })
    @active = Book.where(id: Provide.where(delivered: false).where(user_id: current_user).pluck(:book_id)).where(user: nil)
    @req = Book.where.not(user: nil).where(id: Provide.where(delivered: false).where(user_id: current_user).pluck(:book_id))
    @deliv = Book.where(id: Provide.where(delivered: true).where(user_id: current_user).pluck(:book_id))
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])
  end

  # GET /books/new
  def new
    @book = Book.new
    if !params[:result].nil?
      @result = params[:result]
    end
  end

  # GET /books/1/edit
  def edit
  end
  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @provide = Provide.create
    respond_to do |format|
      if @book.save
        @provide.book = @book
        @provide.user = current_user
        @provide.save
        format.html { redirect_to @book, notice: _('Book was successfully created.') }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: _('Book was successfully updated.') }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: _('Book was successfully destroyed.') }
      format.json { head :no_content }
    end
  end

  def req
    @book = Book.find(params[:b_id])
    @book.with_lock do
      @book.user = current_user
      @wish = Wishlist.where(user_id: current_user).where(book_id: @book.id).first
      unless @wish.nil?
        @wish.destroy
      end
      if @book.save!
        redirect_to :root, notice: _('Required book successfully!')
      else
        redirect_to :root, alert: _('The operation isn\'t successful!')
      end
    end
  end

  def received
    @rec = Book.where(user_id: current_user).where(id: Provide.where(delivered: true).pluck(:book_id))
  end

  def requests
    @wish = Book.where(user_id: nil).where(id: Wishlist.where(user_id: current_user).pluck(:book_id))
    @req = Book.where(user_id: current_user).where(id: Provide.where(delivered: false).pluck(:book_id))
  end

  def remove
    @book = Book.find(params[:b_id])
    @book.with_lock do
      @book.user = nil
      if @book.save!
        redirect_to :root, notice: _('Request cancelled!')
      else
        redirect_to :root, alert: _('The operation isn\'t successful!')
      end
    end
  end

  def show_info
    @book = Book.find(params[:id_bo])
    @x = params[:u]
    if @x.to_i == 1
      @u = User.where(id: Provide.where(book_id: @book.id).pluck(:user_id)).first
    else
      @u = User.find(@book.user_id)
    end
  end

  def search
    if params[:search]
      @books = Book.title_like("%#{params[:search]}%").where(user_id: nil).where(id: Provide.where.not(user_id: current_user).pluck(:book_id)).order('title')
    else
      @books = Book.where(user_id: nil).where(id: Provide.where.not(user_id: current_user).pluck(:book_id))
    end
  end

  def gbsearch
    respond_to do |format|
      # if !params[:search].blank?
      if params[:search]
        # @book_json = []
        query = params[:search][:query]
        @result = GoogleBooks.search(query).first
        @book = Book.build(@result) unless @result.nil?
        # @book_json << @result
        # render "book_form", layout: false
        format.html { render 'book_form', layout: false }
        # format.json { render json: @book_json }
      else
        # render nothing: true
        @book = Book.new
        format.html { render 'new', layout: false }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:title, :autor, :publisher, :isbn, :pages, :year, :description, :bookbinding, :language, :category, :typeOfSale, :status, :cover)
  end
end
