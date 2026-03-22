import SwiftUI

struct SuccessView: View {
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            Image(systemName: "trophy.fill")
                .font(.system(size: 80))
                .foregroundStyle(.yellow)

            VStack(spacing: 8) {
                Text("YOU WIN!")
                    .font(.system(size: 38, weight: .black, design: .rounded))
                    .foregroundColor(.green)
            }

            Spacer()

            Button(action: onRetry) {
                Label("Play Again", systemImage: "arrow.clockwise")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(Color.green)
                    .cornerRadius(18)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 24)
        .background(Color(.systemBackground))
        .navigationBarHidden(true)
    }
}

#Preview {
    SuccessView {}
}
