import Foundation
import Combine

protocol TimerServiceProtocol: AnyObject {
    var maxGameDurationInSeconds: Int { get }
    var remainingTimePublisher: AnyPublisher<Int, Never> { get }
    var timerFinishedPublisher: AnyPublisher<Void, Never> { get }
    func start()
    func stop()
}

final class TimerService: TimerServiceProtocol {
    private(set) var maxGameDurationInSeconds: Int
    private let remainingTimeSubject: CurrentValueSubject<Int, Never>
    private let timerFinishedSubject = PassthroughSubject<Void, Never>()
    private var timerCancellable: AnyCancellable?

    var remainingTimePublisher: AnyPublisher<Int, Never> {
        remainingTimeSubject.eraseToAnyPublisher()
    }

    var timerFinishedPublisher: AnyPublisher<Void, Never> {
        timerFinishedSubject.eraseToAnyPublisher()
    }

    init(maxGameDurationInSeconds: Int = 60) {
        self.maxGameDurationInSeconds = maxGameDurationInSeconds
        remainingTimeSubject = .init(maxGameDurationInSeconds)
    }

    func start() {
        stop()
        remainingTimeSubject.send(maxGameDurationInSeconds)
        timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                let next = remainingTimeSubject.value - 1
                remainingTimeSubject.send(next)
                if next <= 0 {
                    stop()
                    timerFinishedSubject.send()
                }
            }
    }

    func stop() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }

    deinit { stop() }
}
