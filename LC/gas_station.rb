# @param {Integer[]} gas
# @param {Integer[]} cost
# @return {Integer}

def find_potential_stations(gas, cost)
  potential_stations = []

  gas.each_with_index do |station_gas, idx|
    if station_gas - cost[idx] >= 0
      potential_stations << idx
    end
  end

  return potential_stations
end

def form_clusters_of_adj_potential_stations(potential_stations, num_of_stations)
  clusters = []
  cluster = []

  potential_stations.each do |station_idx|
    if cluster.empty? || cluster.last + 1 == station_idx
      cluster << station_idx
    else
      clusters << cluster
      cluster = [station_idx]
    end
  end

  clusters << cluster

  # Concatenate first cluster to last cluster if last cluster includes the last station
  if clusters.length > 1 && clusters.last.last == num_of_stations-1
    clusters[-1] += clusters.shift
  end

  return clusters
end

def calc_eff_fuel_at_beg_each_cluster(clusters, gas, cost)
  eff_fuel = {}

  clusters.each do |cluster|
    eff_fuel[cluster.first] = 0
    cluster.each do |station_idx|
      eff_fuel[cluster.first]+=gas[station_idx]-cost[station_idx]
    end
  end

  return eff_fuel
end

def find_station_with_max_eff_fuel(eff_fuel)
  best_station = nil
  best_station_eff_fuel = 0

  eff_fuel.each do |k, v|
    if v > best_station_eff_fuel
      best_station_eff_fuel = v
      best_station = k
    end
  end

  return best_station
end

def proper_starting_station?(station_idx, gas, cost)
  tank = gas[station_idx] - cost[station_idx]
  full_cycle_traversed = false
  i = station_idx + 1

  while true
    i = 0 if i == gas.length

    tank+=gas[i] - cost[i]

    if tank < 0
      return false
    elsif i == station_idx
      return true
    end

    i+=1
  end
end

def can_complete_circuit(gas, cost)
  return -1 if (gas.reduce(:+) - cost.reduce(:+)) < 0
  return 0 if gas.length == 1

  # Find idxs of potential stations
  potential_stations = find_potential_stations(gas, cost)

  potential_stations.each do |station_idx|
    if proper_starting_station?(station_idx, gas, cost)
      return station_idx
    end
  end

  # Cluster adjacent potential stations
  # clusters = form_clusters_of_adj_potential_stations(potential_stations, gas.length)

  # Calculate the effective amount of fuel in the tank at the beginning of each cluster
  # eff_fuel = calc_eff_fuel_at_beg_each_cluster(clusters, gas, cost)

  # Find station with max eff fuel
  # return find_station_with_max_eff_fuel(eff_fuel)
end
