
def factors(num)
    (1..num).to_a.select { |n| num % n == 0 }
end

def subwords(word, dictionary)
    dictionary.select { |subword| word.include?(subword) }
end

def doubler(arr)
    arr.map { |ele| ele * 2 }
end

class Array

    def bubble_sort!(&prc)
        prc ||= Proc.new { |a, b| a <=> b}

        sorted = false
        until sorted
            sorted = true
            (0...self.length - 1).each do |idx|
                if prc.call(self[idx], self[idx + 1]) == 1
                    self[idx], self[idx + 1] = self[idx + 1], self[idx]
                    sorted = false
                end
            end
        end
        return self
    end

    def bubble_sort
        copy = self.dup
        copy.bubble_sort!
    end

    def my_inject(accum = nil, &prc)
        start_point = 0
        if accum == nil
            accum = self.first
            start_point = 1
        end
        (start_point...self.length).each do |idx|
            accum = prc.call(accum, self[idx])
        end
        accum
    end

end

def concatenate(array)
    array.inject do |acum, ele|
        acum + ele
    end
end