import SwiftUI

struct TimerView: View {
    let remaining: Int
    let total: Int

    private var progress: Double {
        guard total > 0 else {
            return 0
        }
        return Double(remaining) / Double(total)
    }

    private var color: Color {
        if remaining > 30 {
            return .green
        }

        if remaining > 10 {
            return .orange
        }

        return .red
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 8)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    color,
                    style: StrokeStyle(lineWidth: 8, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 1), value: remaining)

            VStack(spacing: 1) {
                Text("\(remaining)")
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                    .foregroundColor(color)
                    .contentTransition(.numericText())
                    .animation(.easeInOut(duration: 0.3), value: remaining)
                Text("sec")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .frame(width: 55, height: 55)
    }
}

#Preview {
    TimerView(remaining: 15, total: 60)
}
