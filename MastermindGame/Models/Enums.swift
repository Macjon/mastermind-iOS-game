enum GuessResult: Equatable {
    case correct    // GREEN  — right character, right position
    case misplaced  // ORANGE — right character, wrong position
    case wrong      // RED    — character not in secret
    case unchecked  // default state, no colour
}

enum GameState: Equatable {
    case playing
    case won
    case gameOver
}
