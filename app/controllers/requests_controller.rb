class RequestsController < ApplicationController
  load_and_authorize_resource
  before_action :set_request, only: %i[ show edit update destroy ]
  before_action :authorize_supervisor, only: [:assign_technician, :assign_technician_form]
  before_action :authorize_technician, only: [:attend]

  def index
    @requests = Request.all
  end

  def show
  end

  def new
    @request = Request.new
  end

  def edit
  end

  def create
    @request = Request.new(request_params)
    @request.user = current_user
    @request.status = 'open'

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: "Solicitação criado." }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: "Solicitação atualizada." }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @request.destroy!

    respond_to do |format|
      format.html { redirect_to requests_path, status: :see_other, notice: "Solicitação apagada." }
      format.json { head :no_content }
    end
  end

  def assign_technician
    @request = Request.find(params[:id])
    @technician = User.find(request_params[:assigned_to_id])

    respond_to do |format|
      if @request.update(assigned_to: @technician, status: 'accepted')
        format.html { redirect_to @request, notice: "Técnico atribuído com sucesso." }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { redirect_to @request, alert: "Falha ao atribuir técnico." }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def assign_technician_form
    @request = Request.find(params[:id])
  end

  def attend
    @request = Request.find(params[:id])

    respond_to do |format|
      if @request.attend && @request.save
        format.html { redirect_to @request, notice: "Solicitação atendida com sucesso." }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { redirect_to @request, alert: "Falha ao atender solicitação." }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_request
      @request = Request.find(params[:id])
    end

    def request_params
      params.require(:request).permit(:title, :description, :status, :priority, :resource_id, :user_id, :assigned_to_id)
    end

    def authorize_supervisor
      unless current_user.supervisor?
        redirect_to requests_path, alert: "Apenas supervisores podem atribuir técnicos."
      end
    end

    def authorize_technician
      unless current_user.technician? && @request.accepted?
        redirect_to requests_path, alert: "Apenas técnicos podem atender solicitações aceitas."
      end
    end
end
