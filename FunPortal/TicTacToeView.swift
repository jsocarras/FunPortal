import SwiftUI

enum PlayerMark: String {
    case x = "X"
    case o = "O"
    case empty = ""
}

class TicTacToeViewModel: ObservableObject {
    @Published var board: [PlayerMark] = Array(repeating: .empty, count: 9)
    @Published var currentPlayer: PlayerMark = .x
    @Published var message: String = "Player X's turn"
    
    let winPatterns: [[Int]] = [
        [0,1,2],[3,4,5],[6,7,8], // rows
        [0,3,6],[1,4,7],[2,5,8], // columns
        [0,4,8],[2,4,6] // diagonals
    ]
    
    func tapCell(at index: Int) {
        guard board[index] == .empty else { return }
        board[index] = currentPlayer
        if checkWin(for: currentPlayer) {
            message = "Player \(currentPlayer.rawValue) Wins!"
        } else if board.allSatisfy({ $0 != .empty }) {
            message = "It's a Draw!"
        } else {
            currentPlayer = (currentPlayer == .x) ? .o : .x
            message = "Player \(currentPlayer.rawValue)'s turn"
        }
    }
    
    func checkWin(for player: PlayerMark) -> Bool {
        for pattern in winPatterns {
            if pattern.allSatisfy({ board[$0] == player }) {
                return true
            }
        }
        return false
    }
    
    func reset() {
        board = Array(repeating: .empty, count: 9)
        currentPlayer = .x
        message = "Player X's turn"
    }
}

struct TicTacToeView: View {
    @StateObject var viewModel = TicTacToeViewModel()
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    
    var body: some View {
        VStack {
            Text(viewModel.message)
                .font(.headline)
                .padding()
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0..<9) { index in
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.blue.opacity(0.2))
                            .frame(height: 80)
                            .cornerRadius(10)
                        
                        Text(viewModel.board[index].rawValue)
                            .font(.largeTitle)
                            .bold()
                    }
                    .onTapGesture {
                        viewModel.tapCell(at: index)
                    }
                }
            }
            .padding()
            
            Button("New Game") {
                viewModel.reset()
            }
            .padding()
        }
        .navigationTitle("Tic-Tac-Toe")
    }
}
