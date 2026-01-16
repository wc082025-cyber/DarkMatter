//
//  NoisePlayer.swift
//  DarkMatter
//
//  Created by Chris Wahlberg on 07/01/2026.
//
// MARK: noise player one, exporting currently to contentView
/*
 
 import Foundation
import AVFoundation

/// A singleton that manages continuous white‑noise playback.
final class NoisePlayer: NSObject {
    static let shared = NoisePlayer()
    private var player: AVAudioPlayer?

    private override init() {
        super.init()
        configureAudioSession()
        preparePlayer()
        registerForInterruptions()
    }

    // MARK: - Public API
    func start() {
        guard let player = player, !player.isPlaying else { return }
        player.play()
    }

    func stop() {
        player?.stop()
    }

    // MARK: - Private helpers
    private func configureAudioSession() {
        let session = AVAudioSession.sharedInstance()
        do {
            // .playback allows background audio when the app is in the background
            try session.setCategory(.playback, mode: .default, options: [])
            try session.setActive(true)
        } catch {
            print("Audio session error: \(error)")
        }
    }

    private func preparePlayer() {
        guard let url = Bundle.main.url(forResource: "AnalogSoundscapeShort", withExtension: "m4a") ??
                      Bundle.main.url(forResource: "AnalogSoundscapeShort", withExtension: "wav") ??
                      Bundle.main.url(forResource: "AnalogSoundscapeShort", withExtension: "mp3") else {
            print("Could not locate white_noise file in bundle")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1               // -1 = infinite loop
            player?.volume = 0.5                     // optional: start at 50 %
            player?.prepareToPlay()
        } catch {
            print(" AVAudioPlayer init failed: \(error)")
        }
    }

    // MARK: - Interruption handling (phone call, Siri, etc.)
    private func registerForInterruptions() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleInterruption(_:)),
            name: AVAudioSession.interruptionNotification,
            object: nil)
    }

    @objc private func handleInterruption(_ notification: Notification) {
        guard let info = notification.userInfo,
              let typeRaw = info[AVAudioSessionInterruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue: typeRaw) else { return }

        switch type {
        case .began:
            // Pause when interruption starts
            player?.pause()
        case .ended:
            // Resume if the system says we should
            if let optionsRaw = info[AVAudioSessionInterruptionOptionKey] as? UInt {
                let options = AVAudioSession.InterruptionOptions(rawValue: optionsRaw)
                if options.contains(.shouldResume) {
                    player?.play()
                }
            }
        @unknown default:
            break
        }
    }
}
*/
