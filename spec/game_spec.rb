require "./lib/game.rb"

RSpec.describe Connect4 do
    describe "#move_legal?" do
        game = Connect4.new('p1','p2')
        it "returns false for out of bound move" do
            expect(game.move_legal?(8)).to be false
        end
        it "returns true for inbound move" do
            expect(game.move_legal?(4)).to be true
        end
        it "returns false for stack over 6" do
            6.times { game.move(1,1) }
            expect(game.move_legal?(1)).to be false
        end
    end
    
    describe "#output" do
        game = Connect4.new("p1", "p2")
        it "returns an array the size of 6x7" do
            expect(game.output.count).to eql(42)
        end
        it "returns empty space for empty cell" do
            game.move(1,1)
            expect(game.output[0]).to eql("\s")
        end
        it "returns ⓵ for player 1's cell" do
            expect(game.output[1]).to eql("⓵")
        end
        it "returns ⓶ for player 2's cell" do
            game.move(2,2); game.move(2,2)
            expect(game.output[9]).to eql("⓶")
        end
        it "works for the last corner" do
            6.times {game.move(6,1)}
            expect(game.output[41]).to eql("⓵")
        end
    end

    describe "#victory?" do
        game = Connect4.new("p1", "p2")
        it "returns nil until a win or tide" do
            expect(game.victory?).to be nil
        end
        it "continues to return nil" do
            game.move(1, 1); game.move(2, 2)
            expect(game.victory?).to be nil
        end
        it "returns 1 when player 1 connects 4 vertical pieces" do
            3.times { game.move(1, 1) }
            expect(game.victory?).to eql(1)
        end
        it "returns 2 when player 2 connects 4 horizontal pieces" do
            game= Connect4.new("p1","p2")
            game.move(2, 2); game.move(3, 2); game.move(4, 2); game.move(5, 2)
            expect(game.victory?).to eql(2)
        end
        it "returns 1 when player 1 connects 4 diagonal pieces" do
            game = Connect4.new("p1","p2")
            game.move(1, 1); game.move(2, 2); game.move(2, 1)
            game.move(3, 2); game.move(3, 2); game.move(3, 1)
            game.move(4, 1); game.move(4, 2); game.move(4, 2); game.move(4, 1)
            expect(game.victory?).to eql(1)
        end
        it "returns 3 when the board is filled without a winner" do
            game = Connect4.new("p1","p2")
            3.times {game.move(0, 1)}; 3.times {game.move(0, 2)}
            3.times {game.move(1, 2)}; 3.times {game.move(1, 1)}
            3.times {game.move(2, 1)}; 3.times {game.move(2, 2)}
            3.times {game.move(3, 2)}; 3.times {game.move(3, 1)}
            3.times {game.move(4, 1)}; 3.times {game.move(4, 2)}
            3.times {game.move(5, 2)}; 3.times {game.move(5, 1)}
            3.times {game.move(6, 1)}; 3.times {game.move(6, 2)}
            expect(game.victory?).to eql(3)
        end
    end

end