$:.unshift File.dirname('..')

require 'rspec'
require 'game_of_life'

describe Grid do
	subject { described_class.new(20, 20) }

	it 'builds a grid with the right columns and rows' do
		expect(subject.rows).to eq 20
		expect(subject.columns).to eq 20
	end

	it 'has all the cells and they started dead' do
		subject.current_grid.each do |row|
			row.each do |cell|
				expect(cell.dead?)
			end
		end
	end

end

describe RuleCalculator do
	context "Rule 1" do
		it "dies with less than two neighbours" do
			expect(
				RuleCalculator.run_rules([
					[0,0,0],
					[0,1,0],
					[0,0,0]
				], 1, 1)
			).to eq 0
		end

		it "remains dead with less than three neighbours" do
			expect(
				RuleCalculator.run_rules([
					[0,0,1],
					[0,0,0],
					[0,0,0]
				], 1, 1,)
			).to eq 0
		end
	end

	context "Rule 2" do
		it "lives with two or three neighbours" do
			expect(
				RuleCalculator.run_rules([
					[0,1,1],
					[0,1,0],
					[0,0,0]
				], 1, 1)
			).to eq 1
		end
	end

	context "Rule 3" do
		it "remains dead with more than three neighbours" do
			expect(
				RuleCalculator.run_rules([
					[1,1,1],
					[1,0,0],
					[0,0,0]
				], 1, 1)
			).to eq 0
		end
	end

	context "Rule 4" do
		it "is reborn with exactly three neighbours" do
			expect(
				RuleCalculator.run_rules([
					[1,1,1],
					[0,0,0],
					[0,0,0]
				], 1, 1)
			).to eq 1
		end
	end
end

describe NeighbourCalculator do
	it "returns zero whent there are no neighbours" do
		expect(described_class.get_neighbours([
			[0,0,0],
			[0,1,0],
			[0,0,0]
		])).to eq 0
	end

	it "returns 1 when there is one neighbour when you're alive" do
		expect(described_class.get_neighbours([
			[0,0,0],
			[0,1,1],
			[0,0,0]
		])).to eq 1
	end

	it "returns 1 when there is one neighbour when you're dead" do
		expect(described_class.get_neighbours([
			[0,0,0],
			[0,0,1],
			[0,0,0]
		])).to eq 1
	end

	it "returns 1 when there is one neighbour when you're dead" do
		expect(described_class.get_neighbours([
			[0,1,1],
			[0,0,1],
			[0,0,0]
		])).to eq 3
	end

end 

describe WorldTicker do
#	it "expect it to calculate rules for all cells" do
#		input = [
#			[0,0,0,0],
#			[0,0,1,0],
#			[0,1,1,0],
#			[0,0,0,0]
#		]
#
#		result = [
#			[0,0,0,0],
#			[0,1,1,0],
#			[0,1,1,0],
#			[0,0,0,0]
#		]
#
#		expect(described_class.calculate_world(input)).to eq result
#	end
end

describe MatrixGenerator do
  let(:input) { [
        [0,0,1],
        [0,1,0],
        [0,0,0]
      ]}

  context "#elements_above" do
    it "returns all the top cells for the given cell" do
      result = [0, 1, 0]
      expect(described_class.elements_above(input, 1, 1)).to eq result
    end

    it "returns no elements if there is no top cells" do
      result = []
      expect(described_class.elements_above(input, 0, 0)).to eq result
    end

    it "returns only two elements if there no left cells" do
      result = [0, 0]
      expect(described_class.elements_above(input, 1, 0)).to eq result
    end

    it "returns only two elements if there no left cells" do
      result = [1, 0]
      expect(described_class.elements_above(input, 1, 2)).to eq result
    end
  end

  context "#elements_on_sides" do 
    it "returns elements on both the sides" do 
      result = [0, 0]
      expect(described_class.elements_on_sides(input, 1, 1)).to eq result
    end

    it "returns only elemnets on the left side if there are no elements to the right" do
      result = [1]
      expect(described_class.elements_on_sides(input, 1, 2)).to eq result
    end
  end
end

describe Cell do
	

	context 'when it is alive' do
		subject { described_class.new(1) }

		it 'knows that it is alive' do
			expect(subject.state).to eq 1
		end
	end

	context 'when it is dead' do
		subject { described_class.new(0) }

		it 'knows that it is dead' do
			expect(subject.state).to eq 0
		end
	end


end

