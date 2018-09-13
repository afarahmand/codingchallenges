# Opens a file and returns an array
#   The array contains each line of the file in-order as a string
def read_file(path_infile)
  infile = File.open(path_infile, 'r')
  lines = infile.readlines
  infile.close

  lines.shift # Dump the first line which has identifiers but no data
  lines
end

# Receives a string containing a single action and returns an object
def process_action(input_action_string)
  temp = input_action_string.delete("\"[] ").split(",")
  action = {
    "source": temp[0].split(":")[0],
    "value": temp[0].split(":")[1].to_i,
    "action_type": temp[1].split(":")[1]
  }

  action
end

# Receives a string of multiple actions and returns an array of actions
#   where each action is an object
def process_actions(input_actions_string)
  action_string = ""
  actions = []

  beg_idx = 2
  fin_idx = input_actions_string.index("}")
  while beg_idx
    action_string = input_actions_string[(beg_idx+1)..(fin_idx-1)]
    beg_idx = input_actions_string.index("{", fin_idx)
    fin_idx = input_actions_string.index("}", beg_idx) if beg_idx
    actions << process_action(action_string)
  end

  actions
end

# Reads source1.csv, then returns an array of objects, each object
#   representing a row in the file
def read_file_source1(path_infile)
  lines = read_file(path_infile)
  result = []

  lines.each_with_index do |line_str, idx|
    line_arr = line_str.chomp.split(",")
    audience_arr = line_arr[1].split("_")
    line_obj = {
      "id": idx,
      "campaign_id": line_arr[0],
      "state": audience_arr[0],
      "hair_color": audience_arr[1],
      "age_range": audience_arr[2],
      "impressions": line_arr[2].to_i
    }

    result << line_obj
  end

  result
end

# Reads source2.csv, then returns an array of objects, each object
#   representing a row in the file, each action is an embedded object
def read_file_source2(path_infile)
  lines = read_file(path_infile)
  result = []

  lines.each_with_index do |line_str, idx|
    beg_index_of_part2 = line_str.index("\"[{")
    line_arr_part1 = line_str.chomp[0..(beg_index_of_part2 - 2)].split(",")
    line_arr_part2 = line_str.chomp[beg_index_of_part2..(-1)]

    line_obj = {
      "id": idx,
      "campaign_id": line_arr_part1[0],
      "ad_type": line_arr_part1[1],
      "date": line_arr_part1[2],
      "spend": line_arr_part1[3].to_i,
      "actions": process_actions(line_arr_part2)
    }

    result << line_obj
  end

  result
end

def question1(source1, source2)
  purple_hair_campaign_ids = []
  total_spend = 0

  source1.each do |entry|
    if entry[:hair_color] == "purple"
      purple_hair_campaign_ids << entry[:campaign_id]
    end
  end

  source2.each do |entry|
    if purple_hair_campaign_ids.include?(entry[:campaign_id])
      total_spend+=entry[:spend]
    end
  end

  total_spend
end

def question2(source2)
  campaigns_more_than_4_days = 0

  # Sort source2 by campaign_id.  For each campaign id, we will have to find the number of entries with the same
  #  campaign_id but different dates.  If source2 is sorted by campaign_id, we will only have to look at surrounding
  #  entries to make our determination instead of all of the records in source 2.

  source2_sorted = source2.sort{ |x, y| x[:campaign_id] <=> y[:campaign_id] }

  i = 0
  while i < (source2_sorted.length - 1)
    target_campaign_id = source2_sorted[i][:campaign_id]
    campaign_dates = [source2_sorted[i][:date]]
    i+=1

    exit_condition = false
    while !exit_condition && i < source2_sorted.length
      current_campaign_id = source2_sorted[i][:campaign_id]
      campaign_dates << source2_sorted[i][:date] if !campaign_dates.include?(source2_sorted[i][:date])

      # exit condition true when i exceeds bounds OR campaign == 5 dates OR last_campaign_id != current_campaign_id
      if campaign_dates.length > 4
        campaigns_more_than_4_days+=1
        exit_condition = true
      elsif (current_campaign_id != target_campaign_id) || (i >= source2_sorted.length)
        exit_condition = true
      else
        i+=1
      end
    end
  end

  campaigns_more_than_4_days
end

def question3(source2)
  number_of_times_source_h_reported_clicks = 0

  source2.each do |entry|
    entry[:actions].each do |action|
      if action[:source] == "H" && action[:action_type] == "clicks"
        number_of_times_source_h_reported_clicks+=1
      end
    end
  end

  number_of_times_source_h_reported_clicks
end

def question4(source2)
  # An object keyed at the top-level by source
  #   Each source has a subkey for each of :junk and :noise that counts the number of occurrences
  source_count = {}

  # Count the number of times each source reports junk and noise
  source2.each do |entry|
    entry[:actions].each do |action|
      if action[:action_type] == "junk" || action[:action_type] == "noise"
        source_count[action[:source]] = {} if !source_count[action[:source]]
        if source_count[action[:source]][action[:action_type]]
          source_count[action[:source]][action[:action_type]]+=1
        else
          source_count[action[:source]][action[:action_type]]=1
        end
      end
    end
  end

  sources_reporting_more_junk_than_noise = []

  source_count.each do |source, junk_noise_count|
    if junk_noise_count["junk"] > junk_noise_count["noise"]
      sources_reporting_more_junk_than_noise << source
    end
  end

  sources_reporting_more_junk_than_noise
end

def question5(source2)
  total_spend = 0
  total_views = 0

  source2.each do |entry|
    if entry[:ad_type] == "video"
      entry[:actions].each do |action|
        if action[:action_type] == "views"
          total_spend+=entry[:spend]
          total_views+=action[:value]
        end
      end
    end
  end

  (total_spend.to_f/total_views.to_f).round(2)
end

def question6(source1, source2)
  campaign_ids_NY = []
  source_b_conversion_count = 0

  # Find campaign ids targeting NY
  source1.each do |entry|
    campaign_ids_NY << entry[:campaign_id] if entry[:state] == "NY" && !campaign_ids_NY.include?(entry[:campaign_id])
  end

  # Find conversions for the specific campaign_ids
  source2.each do |entry|
    if campaign_ids_NY.include?(entry[:campaign_id])
      entry[:actions].each do |action|
        # Find actions with source B, then find those with action_type conversions
        if (action[:source] == "B" && action[:action_type] == "conversions")
          source_b_conversion_count+=action[:value]
        end
      end
    end
  end

  source_b_conversion_count
end

# 7. what combination of state and hair color had the best CPM?
# CPM => cost(spend) per 1k impressions
def question7(source1, source2)
  campaign_ids_shc = {}              # { campaign_id => state+hair_color}
  shc = ""                           # concatenated string of state+hair_color
  shc_impressions = Hash.new(0)      # { state+hair_color => total impressions }
  shc_spend = Hash.new(0)            # { state+hair_color => total spend }
  shc_best_cpm = []                  # [ shc of best cpm, best cpm value]

  source1.each do |entry|
    shc = entry[:state]+entry[:hair_color]
    campaign_ids_shc[entry[:campaign_id]] = shc
    shc_impressions[shc]+=entry[:impressions]
  end

  source2.each do |entry|
    shc = campaign_ids_shc[entry[:campaign_id]]
    shc_spend[shc]+=entry[:spend]
  end

  # Find state + hair_color with best CPM

  # Set init condition
  shc = shc_impressions.keys.first
  cpm = 1000*shc_spend[shc].to_f/shc_impressions[shc].to_f
  shc_best_cpm = [shc, cpm]

  shc_impressions.each do |shc, impressions|
    cpm = 1000*shc_spend[shc].to_f/impressions.to_f
    shc_best_cpm = [shc, cpm] if cpm > shc_best_cpm[1]
  end

  "The combination of the state #{shc_best_cpm[0][0..1]} and #{shc_best_cpm[0][2..-1]} hair color had the best CPM."
end

def create_report
  source1 = read_file_source1("source1.csv")
  source2 = read_file_source2("source2.csv")

  p "The total spent against people with purple hair is #{question1(source1, source2)}."
  p "#{question2(source2)} campaigns spent on more than 4 days."
  p "Source H reported clicks #{question3(source2)} times."
  p "Sources #{question4(source2)} reported more junk than noise."
  p "The total cost for all video ads is #{question5(source2)}."
  p "There were #{question6(source1, source2)} source B conversions for campaigns targeting NY."
  p question7(source1, source2)
end

beg = Time.now
create_report()
fin = Time.now

p "The program took #{fin - beg} seconds to process."

# Some things I've learned from analyzing the dataset in source2:
#
# 1) All campaign ids are a string of length 36
# 2) value of ad_type field is always either "photo" or "video"
# 3) the value of every date field is the same length as the other date fields
# 4) the value in the spend field is variable length: ranges from length 1 to at least 3 digits


# 1. what was the total spent against people with purple hair?
# 2. how many campaigns spent on more than 4 days?
# 3. how many times did source H report on clicks?
# 4. which sources reported more "junk" than "noise"?
# 5. what was the total cost per view for all video ads, truncated to two decimal places?
# 6. how many source B conversions were there for campaigns targeting NY?
# 7. what combination of state and hair color had the best CPM?
#
# BONUS - include a timestamp of the run time for your solution :)
