def read_file(path_infile)
  infile = File.open(path_infile, 'r')
  raw_lines = infile.readlines
  infile.close

  raw_lines.shift # Dump the first line which has identifiers but no data
  raw_lines
end

def read_file_source1(path_infile)
  raw_lines = read_file(path_infile)
  result = []

  raw_lines.each_with_index do |line, idx|
    raw_entry = line.chomp.split(",")
    raw_field1 = raw_entry[1].split("_")
    entry = {
      "id": idx,
      "campaign_id": raw_entry[0],
      "state": raw_field1[0],
      "hair_color": raw_field1[1],
      "age_range": raw_field1[2],
      "impressions": raw_entry[2].to_i
    }

    result << entry
  end

  result
end

def process_action(raw_action)
  temp = raw_action.delete("\"[] ").split(",")
  action = {
    "source": temp[0].split(":")[0],
    "value": temp[0].split(":")[1].to_i,
    "action_type": temp[1].split(":")[1]
  }

  action
end

# Parse out each individual action per entry from source2
def process_raw_entry_part2(raw_entry)
  raw_action_string = ""
  actions = []

  beg_idx = 2
  fin_idx = raw_entry.index("}")
  while beg_idx
    raw_action_string = raw_entry[(beg_idx+1)..(fin_idx-1)]
    beg_idx = raw_entry.index("{", fin_idx)
    fin_idx = raw_entry.index("}", beg_idx) if beg_idx
    actions << process_action(raw_action_string)
  end

  actions
end

def read_file_source2(path_infile)
  raw_lines = read_file(path_infile)
  result = []

  raw_lines.each_with_index do |line, idx|
    beg_index_of_part2 = line.index("\"[{")
    raw_entry_part1 = line.chomp[0..(beg_index_of_part2 - 2)].split(",")
    raw_entry_part2 = line.chomp[beg_index_of_part2..(-1)]

    entry = {
      "id": idx,
      "campaign_id": raw_entry_part1[0],
      "ad_type": raw_entry_part1[1],
      "date": raw_entry_part1[2],
      "spend": raw_entry_part1[3].to_i,
      "actions": process_raw_entry_part2(raw_entry_part2)
    }

    result << entry
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
  source_h_num_of_clicks = 0

  source2.each do |entry|
    entry[:actions].each do |action|
      if action[:source] == "H" && action[:action_type] == "clicks"
        source_h_num_of_clicks+=1
      end
    end
  end

  source_h_num_of_clicks
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

  p question1(source1, source2)
  p question2(source2)
  p question3(source2)
  p question4(source2)
  p question5(source2)
  p question6(source1, source2)
  p question7(source1, source2)
end

beg = Time.now
create_report()
fin = Time.now

p "The program took #{fin - beg} seconds to process."

# ---
# I intend to make a solve all of the questions using naive solutions in a first pass, then
#  going through one or more additional times to change how source1 and 2 are stored in order
#  to solve the questions in a (potentially) more optimal time.
# ---

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
