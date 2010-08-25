
# No real need for a model backend.
class Quiz #< ActiveRecord::Base
  attr_accessor :step
  attr_accessor :a, :b

  def initialize(step = 1)
    self.step = step
  end

  def question
    @question ||= new_question
  end

  def correct?(user_answer)
    (@a + @b) == user_answer
  end

  def done?
    @step > 3
  end

  private

  def new_question
    case step
    when 1
      @a,@b = dbl_rand_with_offset(10)
    when 2
      @a,@b = dbl_rand_with_offset(100, 10)
    when 3
      @a,@b = dbl_rand_with_offset(1000, 100)
    else
      nil
    end

    "#{@a} + #{@b}"
  end

  def dbl_rand_with_offset(max, offset=0)
    [rand(max) + offset, rand(max) + offset]
  end

end
