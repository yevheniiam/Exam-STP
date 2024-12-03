require 'thread'
require_relative '../mine' # Замініть на ім'я вашого файлу

RSpec.describe MultithreadedSorter do
  describe '#sort' do
    context 'when given an empty array' do
      it 'returns an empty array' do
        sorter = MultithreadedSorter.new([], 3)
        expect(sorter.sort).to eq([])
      end
    end

    context 'when given a single-element array' do
      it 'returns the same array' do
        sorter = MultithreadedSorter.new([42], 3)
        expect(sorter.sort).to eq([42])
      end
    end

    context 'when given a pre-sorted array' do
      it 'returns the same sorted array' do
        sorter = MultithreadedSorter.new([1, 2, 3, 4, 5], 3)
        expect(sorter.sort).to eq([1, 2, 3, 4, 5])
      end
    end

    context 'when given an unsorted array' do
      it 'returns a sorted array' do
        sorter = MultithreadedSorter.new([42, 23, 1, 5, 16], 3)
        expect(sorter.sort).to eq([1, 5, 16, 23, 42])
      end
    end

    context 'when given a large array' do
      it 'sorts correctly' do
        array = Array.new(1000) { rand(1..1000) }
        sorter = MultithreadedSorter.new(array, 4)
        expect(sorter.sort).to eq(array.sort)
      end
    end

    context 'when number of threads is 1' do
      it 'sorts correctly in a single thread' do
        array = [42, 23, 1, 5, 16]
        sorter = MultithreadedSorter.new(array, 1)
        expect(sorter.sort).to eq(array.sort)
      end
    end

    context 'when number of threads is greater than array size' do
      it 'sorts correctly' do
        array = [42, 23, 1, 5, 16]
        sorter = MultithreadedSorter.new(array, 10)
        expect(sorter.sort).to eq(array.sort)
      end
    end
  end
end
