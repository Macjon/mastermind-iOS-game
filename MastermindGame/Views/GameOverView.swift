import SwiftUI

struct GameOverView: View {
    let secret: String
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            Image(systemName: "clock.badge.xmark.fill")
                .font(.system(size: 80))
                .foregroundStyle(.red)

            VStack(spacing: 8) {
                Text("TIME'S UP!")
                    .font(.system(size: 38, weight: .black, design: .rounded))
                    .foregroundColor(.red)

                Text("Better luck next time")
                    .font(.title3)
                    .foregroundColor(.secondary)
            }

            VStack(spacing: 12) {
                Text("The secret was:")
                    .font(.headline)
                    .foregroundColor(.secondary)

                HStack(spacing: 8) {
                    ForEach(Array(secret.enumerated()), id: \.offset) { _, char in
                        Text(String(char))
                            .font(.system(size: 28, weight: .bold, design: .monospaced))
                            .foregroundColor(.primary)
                            .frame(width: 56, height: 56)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(12)
                    }
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)

            Spacer()

            Button(action: onRetry) {
                Label("Try Again", systemImage: "arrow.clockwise")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(Color.blue)
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
    GameOverView(secret: "abcd") {}
}
