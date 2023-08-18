require "application_system_test_case"

class AiPromptsTest < ApplicationSystemTestCase
  setup do
    @ai_prompt = ai_prompts(:one)
  end

  test "visiting the index" do
    visit ai_prompts_url
    assert_selector "h1", text: "Ai prompts"
  end

  test "should create ai prompt" do
    visit ai_prompts_url
    click_on "New ai prompt"

    fill_in "Content", with: @ai_prompt.content
    fill_in "Name", with: @ai_prompt.name
    click_on "Create Ai prompt"

    assert_text "Ai prompt was successfully created"
    click_on "Back"
  end

  test "should update Ai prompt" do
    visit ai_prompt_url(@ai_prompt)
    click_on "Edit this ai prompt", match: :first

    fill_in "Content", with: @ai_prompt.content
    fill_in "Name", with: @ai_prompt.name
    click_on "Update Ai prompt"

    assert_text "Ai prompt was successfully updated"
    click_on "Back"
  end

  test "should destroy Ai prompt" do
    visit ai_prompt_url(@ai_prompt)
    click_on "Destroy this ai prompt", match: :first

    assert_text "Ai prompt was successfully destroyed"
  end
end
