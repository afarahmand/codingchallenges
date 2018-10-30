#                           ━━━━━━━━━━━━━━━━━━━
#                            INSCRIBED SQUARES
#                           ━━━━━━━━━━━━━━━━━━━
# For this problem you'll write a solution which accepts a list of "bits"
# and returns an X-Y coordinate.
# The bits are in an encoding specifying how to nest squares. An empty
# list of bits describes a unit square placed on a coordinate system such
# that the lower left corner is at the origin and the upper right corner
# is at `[1, 1]'. The first two bits describes where another square is
# nested within the unit square. There are four possibilities for how the
# nested square can be placed, corresponding to the two bits:
# • `[0, 0]' inscribed in the lower left quadrant
# • `[1, 0]' inscribed in the lower right quadrant
# • `[0, 1]' inscribed in the upper left quadrant
# • `[1, 1]' inscribed in the upper right quadrant
# The subsequent two bits specifies how the next square is inscribed
# within this new quarter-unit square. This continues until the bits are
# exhausted. You can see examples of how the bits correspond to inscribed
# squares in the table below.
# The solution should return an X-Y coordinate corresponding to the
# *center of the smallest inscribed square*. See the table below for some
# codes and return values:
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Bits          Shape  Center
# ───────────────────────────────────
#  []            □      0.5, 0.5
#  [0, 0]        ◱      0.25, 0.25
#  [1, 0]        ◲      0.75, 0.25
#  [0, 1]        ◰      0.25, 0.75
#  [1, 1]        ◳      0.75, 0.75
#  [0, 0, 0, 0]  ◱, ◱   0.125, 0.125
#  [0, 0, 1, 1]  ◱, ◳   0.375, 0.375
#  [1, 1, 0, 0]  ◳, ◱   0.625, 0.625
#  [1, 1, 1, 1]  ◳, ◳   0.875, 0.875
#  …
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

def inscribed_squares(bits)
  return [0.5, 0.5] if bits.length == 0
  base = 2
  center = [0.5, 0.5]

  i = 0
  while i < bits.length
    base*=2

    # First element in pair
    if bits[i] == 0
      center[0]-=1/base.to_f
    else
      center[0]+=1/base.to_f
    end

    if bits[i+1] == 0
      center[1]-=1/base.to_f
    else
      center[1]+=1/base.to_f
    end

    i+=2
  end

  center
end

a = []
a << []           # □      0.5, 0.5
a << [0, 0]       # ◱      0.25, 0.25
a << [1, 0]       # ◲      0.75, 0.25
a << [0, 1]       # ◰      0.25, 0.75
a << [1, 1]       # ◳      0.75, 0.75
a << [0, 0, 0, 0] # ◱, ◱   0.125, 0.125
a << [0, 0, 1, 1] # ◱, ◳   0.375, 0.375
a << [1, 1, 0, 0] # ◳, ◱   0.625, 0.625
a << [1, 1, 1, 1] # ◳, ◳   0.875, 0.875

a.each{ |test_case| p inscribed_squares(test_case) }
