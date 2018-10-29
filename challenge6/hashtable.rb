class Hashtable
  def initialize
    @size = 8
    @count = 0
    @store = Array.new(@size){ [] }
  end

  def get(key)
    if include(key)
      @store[bucket(key)].each{ |kv_pair| return kv_pair[1] if kv_pair[0] == key }
    else
      return nil
    end
  end

  def set(key, val)
    if !@store[bucket(key)].include?(key)
      if @count == @size
        # resize
      end

      @store[bucket(key)] << [key, val]
      @count+=1
    else
      i = 0
      while i < @store[bucket(key)].length
        if @store[bucket(key)][i][0] == key
          @store[bucket(key)][i][1] = val
        end

        i+=1
      end
    end
  end

  def delete(key)
  end

  private

  def bucket(key)
    key.hash % @size
  end

  def include(key)
    @store[bucket(key)].each do |kv_pair|
      return true if kv_pair[0] == key
    end

    false
  end
end



hasht = Hashtable.new()
hasht.set("<REDACTED>", "best company")
p hasht.get("<REDACTED>")
