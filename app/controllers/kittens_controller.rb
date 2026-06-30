class KittensController < ApplicationController
  before_action :set_kitten, only: [ :show, :edit, :update, :destroy ]
  def index
    @kittens = Kitten.all
    @kitten_count = @kittens.count
  end

  def show
    respond_to do | format |
      format.html
      format.json { render json: @kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      redirect_to @kitten, notice: "Kitten was successfully created."
    else
      flash.now[:alert] = "Form submission failed."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @kitten.update(kitten_params)
      redirect_to @kitten, notice: "Kitten was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @kitten.destroy
    redirect_to kittens_path, notice: "Kitten was successfully destroyed.", status: :see_other
  end

  private

  def set_kitten
    @kitten = Kitten.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do | format |
      format.html { redirect_to kittens_path, alert: "🤡 That kitten doesn't exist, human." }
      format.json { render json: { error: "Kitten record not found" }, status: :not_found }
    end
  end

  def kitten_params
    params.expect(kitten: [ :age, :cuteness, :name, :softness ])
  end
end
