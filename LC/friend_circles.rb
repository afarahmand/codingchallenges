# @param {Integer[][]} m
# @return {Integer}

def find_direct_friends(m, person_index)
  direct_friends = []

  m[person_index].each_with_index do |is_friend, other_person_index|
    if person_index != other_person_index
      direct_friends << other_person_index if is_friend == 1
    end
  end

  direct_friends
end

def all_friends_in_circle(m, person_index)
  friends = find_direct_friends(m, person_index)

  # Find indirect friends
  i = 0
  while i < friends.length
    indirect_friends = find_direct_friends(m, friends[i])
    friends+=indirect_friends.select{ |indirect_friend_index| indirect_friend_index != person_index && !friends.include?(indirect_friend_index)}
    i+=1
  end

  friends.uniq
end

def find_circle_num(m)
  num_of_friend_circles = 0
  friends_accounted_for = []

  [*0...m.length].each do |friend_index|
    if !friends_accounted_for.include?(friend_index)
      num_of_friend_circles+=1
      friends_accounted_for+=all_friends_in_circle(m, friend_index)+[friend_index]
      friends_accounted_for.uniq!
    end
  end

  return num_of_friend_circles
end
