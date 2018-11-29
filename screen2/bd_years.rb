# Given a list of peoples' birth year and death year, find the year(s) in which the most people were alive. ex: [[1910, 1960], [1900, 1953], [1950, 2000]] would return [1950, 1951, 1952]

def get_start_year(years)
  earliest_year = years[0][0]

  years.each do |bd_years|
    earliest_year = bd_years[0] if bd_years[0] < earliest_year
  end

  earliest_year
end

def get_end_year(years)
  latest_year = years[0][1]

  years.each do |bd_years|
    latest_year = bd_years[1] if bd_years[1] > latest_year
  end

  latest_year
end

def get_birth_years(years)
  birth_years = {}

  years.each { |bd_years| birth_years[bd_years[0]] = true }

  birth_years.keys
end

def get_death_years(years)
  death_years = {}

  years.each { |bd_years| death_years[bd_years[1]] = true }

  death_years.keys
end

def years_most_alive(years)
  years_num_people_alive = {}

  start_year = get_start_year(years)
  end_year = get_end_year(years)

  birth_years = get_birth_years(years)
  death_years = get_death_years(years)

  year = start_year
  num_of_people_alive = 0

  while (year <= end_year)
    if birth_years.count(year) > 0
      num_of_people_alive+=birth_years.count(year)
    end

    if death_years.count(year) > 0
      num_of_people_alive-=death_years.count(year)
    end

    years_num_people_alive[num_of_people_alive] = [] if !years_num_people_alive[num_of_people_alive]
    years_num_people_alive[num_of_people_alive] << year

    year+=1
  end

  # Find year maximum people alive
  max = years_num_people_alive.keys.max
  years_num_people_alive[max]
end

years = [[1910, 1960], [1900, 1953], [1950, 2000]]
p years_most_alive(years)
