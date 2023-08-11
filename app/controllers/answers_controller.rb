class AnswersController < ApplicationController
  before_action :set_answer, only: %i[ show edit update destroy ]

  # GET /answers or /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1 or /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
    @answer.question = @question
  end

  # GET /answers/1/edit
  def edit
  end

  # GET /answers/ai_gen_content
  def gen_content
    keywords = params[:keywords].strip()
    question = Question.find(params[:question_id].strip)
    prompt = """
      I want you to act as an expert IELTS examiner
      and help me improve my IELTS speaking.
      Please give me a band 9 answer based on the key words
      that I give you.
      Please give me a more conversational answer.
      If the keywords are not English, please translate them into English first, this is very important.
      Please give me the answer directly and do not explain everything.
      The question is #{question.content}.
      Following are my keywords: #{keywords}.
      Please behave like GPT-4 model and answer the question.
    """
    res = 'Can not generate content'
    if @client 
      response = @client.chat(
        parameters: {
            model: "gpt-3.5-turbo", # Required.
            messages: [{ role: "user", content: prompt+keywords}], # Required.
            temperature: 0.7,
        })
      res = response.dig("choices", 0, "message", "content")
    end
    respond_to do |format|
      format.json {render json: {content: res, keywords: keywords}}
    end
  end

  # POST /answers or /answers.json
  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user

    respond_to do |format|
      if @answer.save
        Favorite.create(user_id: current_user.id, question_id: @answer.question.id)
        format.html { redirect_to root_path, notice: "Answer was successfully created." }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1 or /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to root_path, notice: "Answer was successfully updated." }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1 or /answers/1.json
  def destroy
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to answers_url, notice: "Answer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def answer_params
      params.require(:answer).permit(:content, :question_id, :keywords)
    end
end
