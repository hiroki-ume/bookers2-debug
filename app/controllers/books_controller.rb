class BooksController < ApplicationController

  def show
  	@book = Book.find(params[:id])
    @user = User.find(current_user.id)
  end

  def index
    @user = User.find(current_user.id)
  	@books = Book.all
    @book = Book.new #一覧表示するためにBookモデルの情報を全てくださいのall
  end

  def create
    @books = Book.all
  	@book = Book.new(book_params)
    @book.user_id = current_user.id #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to @book, notice: "successfully created book!"#保存された場合の移動先を指定。
  	else

      flash[:alert] = "error"
  		render :index
  	end
  end

  def edit
  	@book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to :books
    end
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
      flash[:alert] = "error"
  		render "edit"
  	end
  end

  def delete
  	@book = Book.find(params[:id])
  	@book.destoy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
