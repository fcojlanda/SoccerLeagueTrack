import SwiftUI

extension View {
    func headerStyle(width: CGFloat) -> some View {
        self
            .font(.headline)
            .frame(width: width, alignment: .leading)
    }

    func cellStyle(width: CGFloat) -> some View {
        self
            .font(.body)
            .frame(width: width, alignment: .leading)
    }
}
