# @param {Character[][]} grid
# @return {Integer}

def integerize_grid(grid)
  int_grid = []
  grid.each do |row|
    new_row = []
    row.each do |el|
      new_row << el.to_i
    end
    int_grid << new_row
  end

  return int_grid
end

def init_checked_spaces(grid)
  matrix = []
  row = []

  coli = 0
  while coli < grid[0].length
    row << false
    coli+=1
  end

  rowi = 0
  while rowi < grid.length
    matrix << row.dup
    rowi+=1
  end

  return matrix
end

def mark_island_as_checked_space(grid, checked_spaces, rowi, coli)
  toExplore = [[rowi, coli]]

  until toExplore.empty?
    point = toExplore.shift

    if !checked_spaces[point[0]][point[1]] && grid[point[0]][point[1]] == 1
      checked_spaces[point[0]][point[1]] = true
      toExplore.concat(surrounding_unchecked_points(grid, checked_spaces, point))
    end
  end

  return checked_spaces
end

def surrounding_unchecked_points(grid, checked_spaces, point)
  all_surrounding_points = []
  surrounding_unchecked_points = []

  all_surrounding_points << [point[0] - 1, point[1]]
  all_surrounding_points << [point[0] + 1, point[1]]
  all_surrounding_points << [point[0], point[1] - 1]
  all_surrounding_points << [point[0], point[1] + 1]

  all_surrounding_points.each do |potential_point|
    # Check if point within bounds of grid
    if potential_point[0] >= 0 && potential_point[0] < grid.length && potential_point[1] >= 0 && potential_point[1] < grid[0].length
      # Check if point has not already been checked
      if checked_spaces[potential_point[0]][potential_point[1]] == false
        # Check if point is part of island or part of water
        if grid[potential_point[0]][potential_point[1]] == 1
          surrounding_unchecked_points << potential_point
        end
      end
    end
  end

  return surrounding_unchecked_points
end

def num_islands(grid)
  return 0 if grid.length == 0

  grid = integerize_grid(grid)
  num_of_islands = 0
  checked_spaces = init_checked_spaces(grid)

  grid.each_with_index do |row, rowi|
    row.each_with_index do |col, coli|
      if !checked_spaces[rowi][coli]
        if col == 1
          num_of_islands+=1
          checked_spaces = mark_island_as_checked_space(grid, checked_spaces, rowi, coli)
        else
          checked_spaces[rowi][coli] = true
        end
      end
    end
  end

  return num_of_islands
end
