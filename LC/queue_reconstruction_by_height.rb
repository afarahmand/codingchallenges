# @param {Integer[][]} people
# @return {Integer[][]}

def sort_and_group_people(people)
  result = []

  sorted_people = people.sort do |first, second|
    if first[0] == second[0]
      first[1] <=> second[1]
    else
      first[0] <=> second[0]
    end
  end

  # all people in group have same h
  group = [sorted_people[0]]

  sorted_people.slice(1..-1).each do |person|
    if group[0][0] == person[0]
      group << person
    else
      result << group
      group = [person]
    end
  end

  result << group if result[-1] != group

  result
end

def reconstruct_queue(people)
  return people if people.length < 2

  queue = Array.new(people.length)

  sorted_groups = sort_and_group_people(people)

  sorted_groups.each do |group|
    idx = 0
    taller_count = 0

    group.each do |person|
      exit_condition = false

      while idx < queue.length && !exit_condition
        if queue[idx].nil? && taller_count == person[1]
          queue[idx] = person
          exit_condition = true
        end

        taller_count+=1 if queue[idx].nil? || queue[idx][0] >= person[0]
        idx+=1
      end
    end
  end

  queue
end
