import SwiftUI

struct LetterBoxView: View {
    @Binding var letter: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(.secondarySystemBackground))
                .frame(width: 64, height: 64)
                .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)

            TextField("", text: $letter)
                .frame(width: 64, height: 64)
                .multilineTextAlignment(.center)
                .font(.system(size: 28, weight: .bold, design: .monospaced))
                .foregroundColor(.primary)
                .textInputAutocapitalization(.characters)
                .autocorrectionDisabled()
                .keyboardType(.asciiCapable)
        }
    }
}

#Preview {
    LetterBoxView(letter: .constant("A"))
}
