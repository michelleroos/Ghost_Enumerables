class Player

    attr_reader :name

    def initialize(name)
        @name = name
    end

    def guess
        letter = gets.chomp.downcase
    end

    # def alert_invalid_guess(string)

    # end

end