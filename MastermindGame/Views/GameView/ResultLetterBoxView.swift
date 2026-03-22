import SwiftUI

struct ResultLetterBoxView: View {
    let letter: String
    let result: GuessResult

    private var backgroundColor: Color {
        switch result {
        case .correct:   return .green
        case .misplaced: return .orange
        case .wrong:     return .red
        case .unchecked: return Color(.secondarySystemBackground)
        }
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .fill(backgroundColor)
                .frame(width: 64, height: 64)
                .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)

            Text(letter)
                .font(.system(size: 28, weight: .bold, design: .monospaced))
                .foregroundColor(.white)
        }
        .transition(.scale(scale: 0.8).combined(with: .opacity))
    }
}

#Preview {
    ResultLetterBoxView(letter: "t", result: .correct)
    ResultLetterBoxView(letter: "x", result: .wrong)
    ResultLetterBoxView(letter: "?", result: .unchecked)
    ResultLetterBoxView(letter: "z", result: .misplaced)
}
