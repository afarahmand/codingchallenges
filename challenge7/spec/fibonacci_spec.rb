require File.expand_path('code/fibonacci')

describe Fibonacci do
  describe '.calculate' do
    [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765].each_with_index do |value, index|
      context "when n == #{index}" do
        subject { Fibonacci.calculate(index) }

        it { is_expected.to eq value }
      end
    end
  end
end
