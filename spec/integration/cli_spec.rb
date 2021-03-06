def superstacker(command='')
  `bundle exec super-stacker #{command}`
end

describe 'cli' do
  context 'when called with no arguments' do
    it 'should return 0' do
      superstacker

      expect($?).to eq(0)
    end

    it 'should output the help message' do
      output = superstacker

      output.should =~ /^Tasks:/
    end
  end

  context 'when the examples are compiled' do
    it 'should match our known good output' do
      Dir.glob('examples/*').each do |example|
        output = superstacker "template compile #{example}"

        known_file = File.join(example, 'template.json')
        known_output = File.open(known_file) { |f| f.read }

        expect(output).to eq(known_output)
      end
    end
  end

  context 'when comparing two stacks' do
    it 'should match our known good output' do
      a = 'spec/fixtures/compare/a'
      b = 'spec/fixtures/compare/b'
      output = superstacker "stack compare #{a} #{b}"

      known_output = File.read('spec/fixtures/compare/known_good_output')

      expect(output).to eq(known_output)
    end
  end
end
