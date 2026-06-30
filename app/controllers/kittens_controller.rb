class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
    @kitten_count = @kittens.count
    respond_to do | format |
      format.html
      format.json { render json: @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

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
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten.update(params[:id])

    if @kitten.update(kitten_params)
      redirect_to @kitten, notice: "Kitten was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy

    redirect_to kittens_path, notice: "Kitten was successfully destroyed.", status: :see_other
  end

  private

  def kitten_params
    params.expect(kitten: [ :age, :cuteness, :name, :softness ])
  end
end
