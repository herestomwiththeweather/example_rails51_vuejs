class EmployeesController < ApplicationController
  before_action :login_required
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all
    respond_to do |format|
      format.html
      format.json { render :json => @employees }
    end
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      format.json do
        if @employee.save
          render :json => @employee
        else
          render :json => { :errors => @employee.errors.messages }, :status => 422
        end
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      format.json do
        if @employee.update(employee_params)
          render :json => @employee
        else
          render :json => { :errors => @employee.errors.messages }, :status => 422
        end
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.json { render :json => {}, :status => :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      #params.fetch(:employee, {})
      params.require(:employee).permit(:name, :email, :manager)
    end
end
