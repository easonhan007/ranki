class CardsController < ApplicationController
  before_action :set_card, only: %i[ show edit update destroy ]

  # GET /cards or /cards.json
  def index
    @pagy, @cards = pagy(current_user.cards.order('created_at DESC'))
  end

  # GET /cards/1 or /cards/1.json
  def show
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards or /cards.json
  def create
    @card = Card.new(card_params)
    @card.user = current_user

    respond_to do |format|
      if @card.save
        format.html { redirect_to card_url(@card), notice: "Card was successfully created." }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1 or /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to card_url(@card), notice: "Card was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1 or /cards/1.json
  def destroy
    @card.destroy

    respond_to do |format|
      format.html { redirect_to cards_url, notice: "Card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /cards/ai_gen_back 
  def ai_gen_back
    prompt = '''
      你是一位优秀的英语老师，每当我输入一个单词，你需要完成以下任务:
      task1:单词词性、音标、中文释义、英文释义、词根词缀起源故事，一行一个
      task2:用这个单词造三个英文例句附英文翻译 
      将以上任务结果按以下Markdown格式排版输出:
      ### 单词释义  <task1 result>  
      ### 场景例句  <task2 result> 
      第一个单词是: 
    '''
    front = params[:front].strip()
    res = 'Can not generate content'
    if @client 
      response = @client.chat(
        parameters: {
            model: "gpt-3.5-turbo", # Required.
            messages: [{ role: "user", content: prompt+front}], # Required.
            temperature: 0.7,
        })
      res = response.dig("choices", 0, "message", "content")
    end
    respond_to do |format|
      format.json {render json: {content: res, front: front}}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = current_user.cards.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def card_params
      params.require(:card).permit(:front, :back, :learned, :user_id, :deck_id)
    end
end
