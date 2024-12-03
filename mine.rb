require 'thread'

# Клас для багатопоточного сортування
class MultithreadedSorter
  def initialize(array, num_threads)
    @array = array
    @num_threads = num_threads
  end

  # Головний метод сортування
  def sort
    # Розбиваємо масив на частини
    subarrays = split_array(@array, @num_threads)

    # Сортуємо частини паралельно
    sorted_subarrays = sort_in_threads(subarrays)

    # Об'єднуємо результати
    merge_sorted_arrays(sorted_subarrays)
  end

  private

  # Розбиває масив на рівні частини
  def split_array(array, num_parts)
    return [] if array.empty? || num_parts <= 0

    chunk_size = (array.size.to_f / num_parts).ceil
    array.each_slice(chunk_size).to_a
  end

  # Запускає сортування кожної частини в окремому потоці
  def sort_in_threads(subarrays)
    threads = []
    sorted_subarrays = Array.new(subarrays.size)

    subarrays.each_with_index do |subarray, index|
      threads << Thread.new do
        sorted_subarrays[index] = subarray.sort
      end
    end

    # Очікуємо завершення всіх потоків
    threads.each(&:join)
    sorted_subarrays
  end

  # Зливає всі відсортовані підмасиви в один
  def merge_sorted_arrays(sorted_subarrays)
    sorted_subarrays.flatten.sort
  end
end

# Демонстрація роботи
if __FILE__ == $0
  array = [42, 23, 1, 5, 16, 8, 4, 3, 9, 11, 30, 18]
  num_threads = 3

  puts "Original array: #{array}"

  sorter = MultithreadedSorter.new(array, num_threads)
  sorted_array = sorter.sort

  puts "Sorted array: #{sorted_array}"
end
