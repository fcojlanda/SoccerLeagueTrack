import SwiftUI

struct TeamListRowView: View {
    let team: TeamModel
    let onTap: () -> Void

    var body: some View {
        HStack {
            Text("\(team.intRank ?? 0)")
                .cellStyle(width: 40)
            Text(team.strTeam ?? "Unknown")
                .cellStyle(width: 120)
            Text("\(team.intPlayed ?? 0)")
                .cellStyle(width: 40)
            Text("\(team.intWin ?? 0)")
                .cellStyle(width: 40)
            Text("\(team.intLoss ?? 0)")
                .cellStyle(width: 40)
            Text("\(team.intPoints ?? 0)")
                .cellStyle(width: 40)
        }
        .background(Color.white)
        .onTapGesture {
            onTap()
        }
    }
}
