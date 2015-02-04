class PeopleController < ApplicationController
  before_action :set_person, only: [:edit, :update, :destroy]

  # GET /people
  def index
    @people = Person.all
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  def create
    @person = Person.new(person_params)

    if @person.save
      redirect_to people_url, notice: 'Person was successfully created.'
    else
      flash[:notice] = @person.errors
      render :new
    end
  end

  # PATCH/PUT /people/1
  def update
    if @person.update(person_params)
      redirect_to people_url, notice: 'Person was successfully updated.'
    else
      flash[:notice] = @person.errors
      render :edit
    end
  end

  # DELETE /people/1
  def destroy
    @person.destroy
    redirect_to people_url, notice: 'Person was successfully destroyed.'
  end

  # GET /people/categorize
  def categorize
    my_params = person_params rescue {}
    @person = Person.new(my_params)
    @show_results = params[:submitted] == 'true'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def person_params
    params.require(:person).permit(:gender, :height, :weight)
  end
end
