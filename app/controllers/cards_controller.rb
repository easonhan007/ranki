class CardsController < ApplicationController
  before_action :set_card, only: %i[ show edit update destroy, toggle]
  before_action :can_quick_new_card

  # GET /cards or /cards.json
  def index
    @pagy, @cards = pagy(current_user.cards.order('created_at DESC'))
  end

  # GET /cards/1 or /cards/1.json
  def show
    @next_card = current_user.cards.where('created_at < ?', @card.created_at).order('created_at DESC').limit(1)
    @card.touch()
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

  # GET /cards/1/toggle

  def toggle
    respond_to do |format|
      if @card.toggle!(:learned)
        format.html { redirect_to card_url(@card), notice: "Card status updated" }
      else
        format.html { redirect_to card_url(@card), notice: "Can not update the card status" }
      end #if 
    end #repsond_to
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
    prompt = AiPrompt.where(name: 'card').first.content
    front = params[:front].strip()
    res = 'Can not generate content'
    if @client 
      response = @client.chat(
        parameters: {
            model: current_user.llm_model, # Required.
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
