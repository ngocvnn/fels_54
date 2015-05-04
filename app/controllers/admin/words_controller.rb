class Admin::WordsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @words= Word.paginate page: params[:page], per_page: 15
  end

  def new
    @category = Category.find params[:category_id]
    @word = @category.words.build
  end

  def show
    @category = Category.find params[:category_id]
    @word = Word.find params[:id]
  end

  def edit
    @category = Category.find params[:category_id]
    @word = Word.find params[:id]
  end

  def create
    @category = Category.find params[:category_id]
    @word = @category.words.build word_params
    if @word.save
      redirect_to admin_category_path @category
    else
      render :new
    end
  end

  def update
    @word = Word.find params[:id]
    if @word.update_attributes word_params 
      flash[:success] = "Word updated"
      redirect_to admin_category_words_path @word
    else
      render :edit
    end
  end

  def destroy
    Word.find(params[:id]).destroy
    flash[:success] = "Word deleted"
    redirect_to :back 
  end

  private
    def word_params
      params.required(:word).permit(:content, answers_attributes: [:id, :content, 
        :correct, :_destroy])
    end
end