class RequestsController < ApplicationController
  load_and_authorize_resource
  before_action :set_request, only: %i[ show edit update destroy ]

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

  private

    def set_request
      @request = Request.find(params[:id])
    end

    def request_params
      params.require(:request).permit(:title, :description, :status, :priority, :resource_id, :user_id, :assigned_to_id)
    end
end
