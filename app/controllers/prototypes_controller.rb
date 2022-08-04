class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :no_login, only: [:edit, :update, :destroy]
  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else 
      render :new
    end

  end

  def show
    
    @comments = @prototype.comments
    @comment = Comment.new
  end

  def edit
    
  end

  def update
    
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end

  end

  def destroy
    
    @prototype.destroy
    redirect_to root_path
  end


  private
  
  def prototype_params
  params.require(:prototype).permit(:title, :concept, :catch_copy, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def no_login
    redirect_to root_path  unless current_user == @prototype.user
  end

end
