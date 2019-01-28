class Recipe
  attr_reader :name, :description, :prep_time, :difficulty, :marked

  def initialize(name, description, prep_time, difficulty, marked)
    @name = name
    @description = description
    @prep_time = prep_time
    @difficulty = difficulty
    @marked = marked
  end

  def mark!
    @marked = !@marked
  end

  def marked?
    @marked
  end
end
