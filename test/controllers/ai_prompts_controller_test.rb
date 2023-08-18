require "test_helper"

class AiPromptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ai_prompt = ai_prompts(:one)
  end

  test "should get index" do
    get ai_prompts_url
    assert_response :success
  end

  test "should get new" do
    get new_ai_prompt_url
    assert_response :success
  end

  test "should create ai_prompt" do
    assert_difference("AiPrompt.count") do
      post ai_prompts_url, params: { ai_prompt: { content: @ai_prompt.content, name: @ai_prompt.name } }
    end

    assert_redirected_to ai_prompt_url(AiPrompt.last)
  end

  test "should show ai_prompt" do
    get ai_prompt_url(@ai_prompt)
    assert_response :success
  end

  test "should get edit" do
    get edit_ai_prompt_url(@ai_prompt)
    assert_response :success
  end

  test "should update ai_prompt" do
    patch ai_prompt_url(@ai_prompt), params: { ai_prompt: { content: @ai_prompt.content, name: @ai_prompt.name } }
    assert_redirected_to ai_prompt_url(@ai_prompt)
  end

  test "should destroy ai_prompt" do
    assert_difference("AiPrompt.count", -1) do
      delete ai_prompt_url(@ai_prompt)
    end

    assert_redirected_to ai_prompts_url
  end
end
