class Array

    def my_each(&prc)
        idx = 0
        while idx < self.length
            prc.call(self[idx])
            idx += 1
        end
        self
    end

    def my_select(&prc)
        new_arr = []
        self.my_each {|ele| new_arr << ele if prc.call(ele)}
        new_arr
    end

    def my_reject(&prc)
        new_arr = []
        self.my_each {|ele| new_arr << ele unless prc.call(ele)}
        new_arr
    end

    def my_any?(&prc)
        self.my_each {|ele| return true if prc.call(ele)}
        false
    end

    def my_all?(&prc)
        self.my_each {|ele| return false if !prc.call(ele)}
        true
    end

    def my_flatten
        return [self] if !self.is_a?(Array) # BC
        return_arr = []
        self.each do |ele|
            if ele.is_a?(Array)
                return_arr += ele.my_flatten
            else
                return_arr << ele
            end
        end
        return_arr
    end 

    def my_zip(*arr)
        arr.unshift(self)
        length = self.length
        zipped = Array.new(length) { Array.new(arr.length, 0) }
        
        arr.each_with_index do |subarr, idx1| # [0, 0]
            subarr.each_with_index do |ele, idx2| # 0, 1
                if zipped[idx2]
                    if arr[idx1][idx2]
                        zipped[idx2][idx1] = ele
                    else
                        zipped[idx2][idx1] = nil
                    end
                end
            end
        end
        zipped
    end

    def my_rotate(num=1)
        arr = self.dup
        if num > 0
            num.times do 
                ele = arr.shift
                arr << ele 
            end
        else
            num.abs.times do
                ele = arr.pop
                arr.unshift(ele)
            end
        end
        arr
    end

    def my_join(sep='')
        self.join(sep)
    end

    def my_reverse
        new_arr = []
        self.length.times do 
            new_arr << self.pop
        end
        new_arr
    end

end

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]

# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"

# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# [[ , , ],[ , , ],[ , , ]]

# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten 
# => [1, 2, 3, 4, 5, 6, 7, 8]

# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end
# # => 1
#      2
#      3
#      1
#      2
#      3

# p return_value  # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []

# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true
