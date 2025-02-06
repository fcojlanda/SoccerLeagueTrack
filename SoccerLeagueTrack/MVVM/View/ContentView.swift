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
        VStack(spacing: 0) {
            TeamListHeaderView()

            List(viewModel.teams, id: \.idTeam) { team in
                TeamListRowView(team: team) {
                    handleRowTap(for: team)
                }
            }
            .listStyle(.plain)
            .padding(.top, 0)
        }
        .task {
            await viewModel.fetchLookUpTable(leagueId: 4328, season: "2020-2021")
        }
        .navigationTitle("Teams")
    }

    private func handleRowTap(for team: TeamModel) {
        print("Tapped on team:", team.strTeam ?? "Unknown")
    }
}

#Preview {
    ContentView()
}
