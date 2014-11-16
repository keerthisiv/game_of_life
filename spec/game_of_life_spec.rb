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

	context 'with alive cell' do

		it 'has one alive cell' do
			subject.populate_grid(1)
			expect(subject.current_grid[0][1].state).to eq 1
		end

	end

end

describe RuleCalculator do
	context "Rule 1" do
		it "dies with less than two neighbours" do
			expect(
				RuleCalculator.run_rules([
					[0,0,0],
					[0,0,0],
					[0,0,0]
				])
			).to eq 0
		end

		it "dies with less than two neighbours" do
			expect(
				RuleCalculator.run_rules([
					[0,0,1],
					[0,0,0],
					[0,0,0]
				])
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
				])
			).to eq 1
		end
	end

	context "Rule 3" do
		it "lives with two or three neighbours" do
			expect(
				RuleCalculator.run_rules([
					[1,1,1],
					[1,0,0],
					[0,0,0]
				])
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
				])
			).to eq 1
		end

		it "is reborn with exactly three neighbours" do
			expect(
				RuleCalculator.run_rules([
					[1,0,1],
					[0,0,0],
					[0,0,0]
				])
			).to eq 0
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
	it "expect it to calculate rules for all cells" do
		input = [
			[0,0,0,0],
			[0,0,1,0],
			[0,1,1,0],
			[0,0,0,0]
		]

		result = [
			[0,0,0,0],
			[0,1,1,0],
			[0,1,1,0],
			[0,0,0,0]
		]

		expect(described_class.calculate_world(input)).to eq result
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

