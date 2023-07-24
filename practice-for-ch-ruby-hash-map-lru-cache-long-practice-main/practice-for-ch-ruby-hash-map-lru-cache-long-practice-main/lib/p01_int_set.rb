class MaxIntSet
  attr_reader :store
  def initialize(max)
    @store = Array.new(max) {false}
    @max = max
  end

  def insert(num)
   validate!(num)
   @store[num] = true
  end

  def remove(num)
    validate!(num)
      @store[num] = false
    
  end

  def include?(num)
      validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, @max)
  end

  def validate!(num)
      raise "Out of bounds" if !is_valid?(num)
      return true
  end
end

class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    if @store.include?(num)
      @store.delete(num)
      @store << num 
    elsif num >= num_buckets 
      @store.shift
      @store << num
    else
      @store << num
    end
      
  end

  def remove(num)
    @store.delete(num)
  end

  def include?(num)
    @store.include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    
    if !include?(num)
       @count += 1
      if @count == num_buckets
      resize!
      end
      @store[num % num_buckets] << num 
     

    end
   
  end

  def remove(num)
    if include?(num)
     @store[num % num_buckets].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    if @count == num_buckets
      new_arr = Array.new(num_buckets * 2) {Array.new}
      @store.each do |subarr|
        subarr.each do |ele|
          new_arr[ele % (num_buckets * 2)] << ele  
        end
      end
    @store = new_arr
    end
  end

  # def [](num)
  #  @store[num % num_buckets] # optional but useful; return the bucket corresponding to `num`
  # end
end