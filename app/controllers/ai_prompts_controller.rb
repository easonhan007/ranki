class AiPromptsController < ApplicationController
  before_action :set_ai_prompt, only: %i[ show edit update destroy ]

  # GET /ai_prompts or /ai_prompts.json
  def index
    @ai_prompts = AiPrompt.all
  end

  # GET /ai_prompts/1 or /ai_prompts/1.json
  def show
  end

  # GET /ai_prompts/new
  def new
    @ai_prompt = AiPrompt.new
  end

  # GET /ai_prompts/1/edit
  def edit
  end

  # POST /ai_prompts or /ai_prompts.json
  def create
    @ai_prompt = AiPrompt.new(ai_prompt_params)

    respond_to do |format|
      if @ai_prompt.save
        format.html { redirect_to ai_prompt_url(@ai_prompt), notice: "Ai prompt was successfully created." }
        format.json { render :show, status: :created, location: @ai_prompt }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ai_prompt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ai_prompts/1 or /ai_prompts/1.json
  def update
    respond_to do |format|
      if @ai_prompt.update(ai_prompt_params)
        format.html { redirect_to ai_prompt_url(@ai_prompt), notice: "Ai prompt was successfully updated." }
        format.json { render :show, status: :ok, location: @ai_prompt }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ai_prompt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ai_prompts/1 or /ai_prompts/1.json
  def destroy
    @ai_prompt.destroy

    respond_to do |format|
      format.html { redirect_to ai_prompts_url, notice: "Ai prompt was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ai_prompt
      @ai_prompt = AiPrompt.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ai_prompt_params
      params.require(:ai_prompt).permit(:name, :content)
    end
end
