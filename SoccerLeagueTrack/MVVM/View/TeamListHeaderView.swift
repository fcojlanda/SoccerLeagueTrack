import SwiftUI

struct TeamListHeaderView: View {
    var body: some View {
        HStack {
            Text("#")
                .headerStyle(width: 40)
            Text("Team")
                .headerStyle(width: 120)
            Text("GP")
                .headerStyle(width: 40)
            Text("GW")
                .headerStyle(width: 40)
            Text("GL")
                .headerStyle(width: 40)
            Text("PTS")
                .headerStyle(width: 40)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
    }
}

