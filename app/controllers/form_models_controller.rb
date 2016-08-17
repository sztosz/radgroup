class FormModelsController < ApplicationController
  before_action :set_form_model, only: [:show, :edit, :update, :destroy]

  # GET /form_models
  # GET /form_models.json
  def index
    @form_models = FormModel.all
  end

  # GET /form_models/1
  # GET /form_models/1.json
  def show
  end

  # GET /form_models/new
  def new
    @form_model = FormModel.new
  end

  # GET /form_models/1/edit
  def edit
  end

  # POST /form_models
  # POST /form_models.json
  def create
    @form_model = FormModel.new(form_model_params)

    respond_to do |format|
      if @form_model.save
        format.html { redirect_to @form_model, notice: 'Form model was successfully created.' }
        format.json { render :show, status: :created, location: @form_model }
      else
        format.html { render :new }
        format.json { render json: @form_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /form_models/1
  # PATCH/PUT /form_models/1.json
  def update
    respond_to do |format|
      if @form_model.update(form_model_params)
        format.html { redirect_to @form_model, notice: 'Form model was successfully updated.' }
        format.json { render :show, status: :ok, location: @form_model }
      else
        format.html { render :edit }
        format.json { render json: @form_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /form_models/1
  # DELETE /form_models/1.json
  def destroy
    @form_model.destroy
    respond_to do |format|
      format.html { redirect_to form_models_url, notice: 'Form model was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form_model
      @form_model = FormModel.find(params[:slug])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def form_model_params
      params.fetch(:form_model).permit(:name, :time_limit, :download_limit, :upload_limit, :cleartext_password)
          .merge(slug: params[:form_model][:name].parameterize)
    end
end
