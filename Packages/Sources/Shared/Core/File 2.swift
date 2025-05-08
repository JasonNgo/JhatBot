//
//  File 2.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-06.
//

import SwiftUI

// Functional Requirements
// - User can scroll through an infinite list of timers
// - User can pause/resume timers by tapping on the timer
// - Timers will continue counting while off screen unless they are paused.
// - Timers will start once they are visible on the screen
// - If paused, text is red, other text is green when running

// Non-functional Requirements
// - Should be fast, pausing a timer should pause it right away
// - Reliable, a paused timer that is scrolled off screen, should be the same value once is scrolled back on

// Out-of-scope:
// Analytics and Logging
// Networking
// Storage

// High-Level Design
// TimerManager
//
// TimerManagerConfig
// - number of timers

// TimerListView - TimerManager

public struct TimerListView: View {

    @State private var manager = TimerManager(config: .init(numberOfTimers: 50, timerInterval: 0.05))

    public init() {

    }

    public var body: some View {
        NavigationStack {
            List {
                ForEach(manager.timers) { timer in
                    Text(formatDuration(timer.duration))
                        .id(timer.id)
                        .foregroundStyle(timer.color)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .onAppear {
                            onTimerAppeared(timer)
                        }
                        .onTapGesture {
                            onTimerTapped(timer)
                        }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Timers")
            .onAppear {
                manager.start()
            }
            .onDisappear {
                manager.stop()
            }
        }
    }

    private func onTimerAppeared(_ timer: TimerModel) {
        if timer.status == .notStarted {
            manager.update(timer) { timer in
                return TimerModel(id: timer.id, duration: timer.duration, status: .running)
            }
        }
    }

    private func onTimerTapped(_ timer: TimerModel) {
        switch timer.status {
        case .notStarted:
            manager.update(timer) { timer in
                return TimerModel(id: timer.id, duration: timer.duration, status: .running)
            }
        case .paused:
            manager.update(timer) { timer in
                return TimerModel(id: timer.id, duration: timer.duration, status: .running)
            }
        case .running:
            manager.update(timer) { timer in
                return TimerModel(id: timer.id, duration: timer.duration, status: .paused)
            }
        }
    }

    private func formatDuration(_ duration: Double) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        let milliseconds = Int((duration.truncatingRemainder(dividingBy: 1)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }

}

#Preview {
    TimerListView()
}

@Observable
public class TimerManager {

    @ObservationIgnored let config: TimerManagerConfig
    public var timers: [TimerModel]
    @ObservationIgnored private var timer: Timer?

    init(config: TimerManagerConfig) {
        self.config = config
        self.timers = (0..<config.numberOfTimers).map { _ in TimerModel(duration: 0, status: .notStarted) }
    }

    func start() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: config.timerInterval, target: self, selector: #selector(onTimerUpdated), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    @objc private func onTimerUpdated() {
        var updatedTimers = timers

        for (index, timer) in updatedTimers.enumerated() where timer.status == .running {
            let updatedTimer = TimerModel(id: timer.id, duration: timer.duration + config.timerInterval, status: timer.status)
            updatedTimers[index] = updatedTimer
        }

        timers = updatedTimers
    }

    func update(_ timer: TimerModel, transform: (TimerModel) -> TimerModel) {
        var updatedTimers = timers

        guard let selectedTimerIndex = updatedTimers.firstIndex(where: { $0.id == timer.id }) else { return }
        updatedTimers[selectedTimerIndex] = transform(timer)

        timers = updatedTimers
    }

}

public struct TimerModel: Identifiable {
    public let id: String
    public let duration: Double
    public let status: TimerStatus

    public var color: Color {
        switch status {
        case .notStarted:
            return Color.black
        case .running:
            return Color.green
        case .paused:
            return Color.red
        }
    }

    public init(id: String = UUID().uuidString, duration: Double, status: TimerStatus) {
        self.id = id
        self.duration = duration
        self.status = status
    }
}

public enum TimerStatus {
    case notStarted
    case running
    case paused
}

public struct TimerManagerConfig {
    let numberOfTimers: Int
    let timerInterval: TimeInterval
}
