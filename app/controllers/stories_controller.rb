class StoriesController < ApplicationController
  before_action :set_story, only: %i[ show edit update destroy ]
  before_action :can_quick_new_card

  # GET /stories or /stories.json
  def index
    @stories = current_user.stories.all
  end

  # GET /stories/1 or /stories/1.json
  def show
  end

  # GET /stories/new
  def new
    @story = Story.new
  end

  # GET /stories/1/edit
  def edit
  end

  # POST /stories or /stories.json
  def create
    @story = Story.new(story_params)
    words = Card.sample(@story.word_count)
    @story.words = words
    @story.user = current_user

    raw_prompt = AiPrompt.where(name: 'story').first
    prompt = ERB.new(raw_prompt.content).result(binding)

    res = "can not generate story for #{words}"
    if @client 
      response = @client.chat(
        parameters: {
            model: current_user.llm_model, # Required.
            messages: [{ role: "user", content: prompt}], # Required.
            temperature: 0.7,
        })
      res = response.dig("choices", 0, "message", "content")
    end
    @story.content = res

    respond_to do |format|
      if @story.save
        format.html { redirect_to story_url(@story), notice: "Story was successfully created." }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1 or /stories/1.json
  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to story_url(@story), notice: "Story was successfully updated." }
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1 or /stories/1.json
  def destroy
    @story.destroy

    respond_to do |format|
      format.html { redirect_to stories_url, notice: "Story was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def story_params
      params.require(:story).permit(:words, :word_count, :content, :user_id)
    end
end
