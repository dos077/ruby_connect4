class Connect4
    attr_reader :player1, :player2

    $game_with = 7
    $game_height = 6

    def initialize(p1, p2)
        @player1 = p1
        @player2 = p2
        @p1_moves = []
        @p2_moves = []
    end
    
    def move_legal?(x)
        y = $game_height-1
        x >= 0 && x < $game_with && !@p1_moves.include?([x, y]) && !@p2_moves.include?([x, y])
    end

    def move(x, player)
        y_array = (0...$game_height).to_a
        y_array.each do |y|
            cordinate = [x, y]
            if !@p1_moves.include?(cordinate) && !@p2_moves.include?(cordinate)
                @p1_moves << cordinate if player == 1
                @p2_moves << cordinate if player == 2
                break
            end
        end
    end

    def output
        ones = @p1_moves.map { |cell| cell[0] + ( cell[1] * 7 ) }
        twos = @p2_moves.map { |cell| cell[0] + ( cell[1] * 7 ) }
        array = []
        ($game_height*$game_with).times do |i|
            if ones.include?(i)
                array << "⓵"
            elsif twos.include?(i)
                array << "⓶"
            else
                array << "\s"
            end
        end
        array
    end

    def connect_four?(array)
        array.each do |cell|
            x, y = cell
            if x < 4
                return true if array.include?([x+1,y]) && array.include?([x+2,y]) && array.include?([x+3,y])
                if y < 3
                    return true if array.include?([x+1,y+1]) && array.include?([x+2,y+2]) && array.include?([x+3,y+3])
                end
            end
            if y < 3
                return true if array.include?([x,y+1]) && array.include?([x,y+2]) && array.include?([x,y+3])
                if x > 2
                    return true if array.include?([x-1,y+1]) && array.include?([x-2,y+2]) && array.include?([x-3,y+3])
                end
            end
        end
        false
    end

    def victory?
        return 1 if connect_four?(@p1_moves)
        return 2 if connect_four?(@p2_moves)
        return 3 if @p1_moves.length + @p2_moves.length >=42
    end

    def zoning(width=$game_with, height=$game_height)
        x_ranges = []
        y_ranges = []
        zones = []
        (width-3).times do |delta_x|
            x_ranges << (delta_x..(delta_x+3)).to_a
        end
        (height-3).times do |delta_y|
            y_ranges << (delta_y..(delta_y+3)).to_a
        end
        x_ranges.each do |x_array|
            y_ranges.each do |y_array|
                zone = []
                x_array.each do |x|
                    y_array.each { |y| zone << [x, y] }
                end
                zones << zone
            end
        end
        zones
    end

end