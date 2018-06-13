# @param {Integer[][]} image
# @param {Integer} sr
# @param {Integer} sc
# @param {Integer} new_color
# @return {Integer[][]}

def valid_coor?(image, ri, ci)
    return false if ri >= image.length || ri < 0
    return false if ci >= image[0].length || ci < 0

    true
end

def all_surrounding_pixels(curr_pos)
    return [
        [curr_pos[0] - 1, curr_pos[1]],
        [curr_pos[0] + 1, curr_pos[1]],
        [curr_pos[0], curr_pos[1] - 1],
        [curr_pos[0], curr_pos[1] + 1]
    ]
end

def valid_surrounding_pixels(image, current_position)
    all_surr_pixels = all_surrounding_pixels(current_position)
    valid_surr_pixels = []

    all_surr_pixels.each do |pos|
        valid_surr_pixels << pos if valid_coor?(image, pos[0], pos[1])
    end

    return valid_surr_pixels
end

def valid_surrounding_pixels_of_different_color(image, current_position, old_color)
    valid_surr_pixels = valid_surrounding_pixels(image, current_position)
    surr_pixels_diff_color = []

    valid_surr_pixels.each do |pos|
        surr_pixels_diff_color << pos if old_color == image[pos[0]][pos[1]]
    end

    surr_pixels_diff_color
end

def flood_fill(image, sr, sc, new_color)
    return image if image[sr][sc] == new_color

    old_color = image[sr][sc]
    curr_pos = [sr, sc]
    queue = []

    queue+=valid_surrounding_pixels_of_different_color(image, curr_pos, old_color)
    # p "Valid surr"
    # p queue

    image[curr_pos[0]][curr_pos[1]] = new_color

    while queue.length > 0
        curr_pos = queue.shift
        queue+=valid_surrounding_pixels_of_different_color(image, curr_pos, old_color)
        image[curr_pos[0]][curr_pos[1]] = new_color
    end

    image
end
