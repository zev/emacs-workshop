require File.join(File.dirname(__FILE__), '..', 'test_helper')

class CalculatorControllerTest < ActionController::TestCase

  def test_index
    get(:index)
    assert_response :success
    assert_tag :tag => "input", :attributes => { :name => "name" }
  end

  def test_game_starts
    post(:game, { :name => 'mu'})
    assert_response :success
    assert_equal 'mu', assigns(:name)
    assert_equal 1, assigns(:step)
  end
end
