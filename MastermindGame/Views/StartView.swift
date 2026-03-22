import SwiftUI

struct StartView: View {

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: 16) {
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 72))
                    .foregroundStyle(.blue)

                Text("MASTERMIND")
                    .font(.system(size: 38, weight: .black, design: .rounded))

                Text("Crack the 4-letter code\nbefore time runs out.")
                    .font(.title3)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }

            Spacer()

            VStack(alignment: .leading, spacing: 14) {
                Text("How it works")
                    .font(.headline)
                    .padding(.bottom, 2)

                RuleRow(color: .green,  text: "Correct letter, correct position")
                RuleRow(color: .orange, text: "Correct letter, wrong position")
                RuleRow(color: .red,    text: "Letter not in the code")

                HStack(spacing: 10) {
                    Image(systemName: "clock")
                        .foregroundColor(.secondary)
                    Text("You have **60 seconds** per game.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 4)
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(18)

            Spacer()

            Button {
                // TODO: goto start screen
            } label: {
                Text("START GAME")
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(Color.blue)
                    .cornerRadius(18)
            }

            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

fileprivate struct RuleRow: View {
    let color: Color
    let text: String

    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 6)
                .fill(color)
                .frame(width: 24, height: 24)
            Text(text)
                .font(.subheadline)
        }
    }
}

#Preview {
    StartView()
}
