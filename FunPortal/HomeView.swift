import SwiftUI

struct Game: Identifiable {
    let id = UUID()
    let name: String
    let iconName: String
    let destination: AnyView
}

struct HomeView: View {
    let games: [Game] = [
        Game(name: "Tic-Tac-Toe", iconName: "gamecontroller.fill", destination: AnyView(TicTacToeView()))
    ]
    
    var body: some View {
        NavigationView {
            List(games) { game in
                NavigationLink(destination: game.destination) {
                    HStack {
                        Image(systemName: game.iconName)
                        Text(game.name)
                    }
                }
            }
            .navigationTitle("Game Portal")
        }
    }
}
