require File.join(File.dirname(__FILE__), '..', 'test_helper')

class QuizTest < ActiveSupport::TestCase

  def test_question_from_step_1
    assert_kind_of Quiz, Quiz.new(1)
  end

  def test_question_string
    quiz = Quiz.new
    reg = /(\d+) \+ (\d+)/
    assert_match reg, quiz.question
    assert quiz.correct?(quiz.a + quiz.b)
    assert !quiz.correct?(quiz.a + quiz.b + 1)
  end

end
