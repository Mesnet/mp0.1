require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    @task = tasks(:one)
  end

  test "visiting the index" do
    visit tasks_url
    assert_selector "h1", text: "Tasks"
  end

  test "creating a Task" do
    visit tasks_url
    click_on "New Task"

    check "Activ" if @task.activ
    fill_in "Date", with: @task.date
    fill_in "Description", with: @task.description
    fill_in "Done at", with: @task.done_at
    fill_in "Done by", with: @task.done_by
    fill_in "Parent", with: @task.parent_id
    fill_in "Position", with: @task.position
    fill_in "Title", with: @task.title
    fill_in "User", with: @task.user_id
    click_on "Create Task"

    assert_text "Task was successfully created"
    click_on "Back"
  end

  test "updating a Task" do
    visit tasks_url
    click_on "Edit", match: :first

    check "Activ" if @task.activ
    fill_in "Date", with: @task.date
    fill_in "Description", with: @task.description
    fill_in "Done at", with: @task.done_at
    fill_in "Done by", with: @task.done_by
    fill_in "Parent", with: @task.parent_id
    fill_in "Position", with: @task.position
    fill_in "Title", with: @task.title
    fill_in "User", with: @task.user_id
    click_on "Update Task"

    assert_text "Task was successfully updated"
    click_on "Back"
  end

  test "destroying a Task" do
    visit tasks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Task was successfully destroyed"
  end
end
