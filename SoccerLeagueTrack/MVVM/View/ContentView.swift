//
//  ContentView.swift
//  SoccerLeagueTrack
//
//  Created by Francisco Landa Torres on 01/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = LeagueViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                List(viewModel.teams, id: \.idTeam) { team in
                    Text(team.strTeam ?? "Unknown Team")
                }
            }
        }
        .task {
            await viewModel.fetchLookUpTable(leagueId: 4328, season: "2020-2021")
        }
        .navigationTitle("Teams")
    }
}

#Preview {
    ContentView()
}
