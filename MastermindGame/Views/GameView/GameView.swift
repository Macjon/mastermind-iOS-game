import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var inputLetters: [String] = ["", "", "", ""]
    @FocusState private var focusedIndex: Int?

    private var allFilled: Bool {
        inputLetters.allSatisfy { !$0.isEmpty }
    }

    var body: some View {
        VStack(spacing: 0) {
            header

            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(viewModel.completedGuesses.indices, id: \.self) { rowIndex in
                            completedRow(viewModel.completedGuesses[rowIndex]).id(rowIndex)
                        }

                        if viewModel.gameState == .playing {
                            activeRow.id("active")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                }
                .onChange(of: viewModel.completedGuesses.count) {
                    // Reset
                    inputLetters = ["", "", "", ""]
                    focusedIndex = 0
                    withAnimation(.easeOut(duration: 0.3)) {
                        proxy.scrollTo("active", anchor: .bottom)
                    }
                }
                .onAppear {
                    viewModel.startGame()
                    focusedIndex = 0
                }
            }
        }
        .background(Color(.systemBackground))
        .navigationBarHidden(true)
        .contentShape(Rectangle())
        .onTapGesture { focusedIndex = nil }
    }

    private var activeRow: some View {
        VStack(spacing: 10) {
            inputBoxRow
            checkButton
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }

    private func binding(for index: Int) -> Binding<String> {
        Binding(
            get: { inputLetters[index] },
            set: { newValue in
                let previous = inputLetters[index]
                let filtered = String(newValue.filter { $0.isLetter }.uppercased().suffix(1))
                inputLetters[index] = filtered

                if !filtered.isEmpty, filtered != previous {
                    focusedIndex = index < 3 ? index + 1 : nil
                }
            }
        )
    }
}

// MARK: Views
extension GameView {

    private var header: some View {
        return HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("MASTERMIND")
                    .font(.system(size: 34, weight: .black, design: .rounded))
                Text("Guess the 4-letter code")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            TimerView(remaining: viewModel.remainingTime, total: viewModel.maxGameDurationInSeconds)
        }
        .padding(.horizontal, 24)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }

    private var inputBoxRow: some View {
        HStack(spacing: 10) {
            ForEach(0..<4, id: \.self) { index in
                LetterBoxView(letter: binding(for: index))
                    .focused($focusedIndex, equals: index)
            }
        }
    }

    private func completedRow(_ row: [LetterBox]) -> some View {
        HStack(spacing: 10) {
            ForEach(row) { box in
                ResultLetterBoxView(letter: box.letter, result: box.result)
            }
        }
    }

    private var checkButton: some View {
        return Button {
            focusedIndex = nil
            viewModel.checkGuess(letters: inputLetters)
        } label: {
            Text("CHECK")
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .frame(width: 286)
                .padding(.vertical, 14)
                .background(allFilled ? .blue : .gray)
                .cornerRadius(14)
        }
        .disabled(!allFilled)
        .animation(.easeInOut(duration: 0.15), value: allFilled)
        .padding(.top, 16)
    }
}
