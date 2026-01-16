//
//  DarkMatterPlayer.swift
//  DarkMatter
//
//  Created by Chris Wahlberg on 08/01/2026.
//

//
//

//
//  DarkMatterPlayer.swift
//  DarkMatter
//

import Foundation
import AVFoundation

/// A singleton that can play any bundled audio file on an infinite loop,
/// expose a mutable `volume` property, and survive backgrounding.
final class DarkMatterPlayer: NSObject {

    // MARK: – Shared instance
    static let shared = DarkMatterPlayer()

    // MARK: – Private state
    private var player: AVAudioPlayer?

    // MARK: – Public mutable volume (0.0 … 1.0)
    var volume: Float {
        get { player?.volume ?? 0.5 }
        set {
            player?.volume = max(0.0, min(1.0, newValue))
        }
    }

    // MARK: – Init
    private override init() {
        super.init()
        configureAudioSession()
        registerForInterruptions()
        restoreLastState()
    }

    // -----------------------------------------------------------------------
    // MARK: – Public API
    // -----------------------------------------------------------------------

    /// Play the file whose **base name** you pass in.
    /// Supported extensions are tried in order: m4a, wav, mp3, caf.
    /// If the same file is already playing, the call is ignored.
    func start(fileName: String) {
        // Guard against re‑starting the same file.
        if let p = player,
           p.url?.lastPathComponent.hasPrefix(fileName) == true,
           p.isPlaying { return }

        guard let url = urlForFile(named: fileName) else {
            print("Could not locate '\(fileName)' in bundle")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1          // infinite repeat
            player?.volume = volume            // respect current volume
            player?.prepareToPlay()
            player?.play()
            print(" Started '\(url.lastPathComponent)'")
            saveLastState(fileName: fileName)
        } catch {
            print(" AVAudioPlayer error: \(error.localizedDescription)")
        }
    }

    /// Stop playback and release the player.
    func stop() {
        player?.stop()
        player = nil
        print(" Stopped playback")
        clearSavedState()
    }

    // -----------------------------------------------------------------------
    // MARK: – Private helpers
    // -----------------------------------------------------------------------

    private func configureAudioSession() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playback, mode: .default, options: [])
            try session.setActive(true)
            print("Audio session active")
        } catch {
            print(" Audio session error: \(error.localizedDescription)")
        }
    }

    private func urlForFile(named name: String) -> URL? {
        let extensions = ["m4a", "wav", "mp3", "caf"]
        for ext in extensions {
            if let url = Bundle.main.url(forResource: name, withExtension: ext) {
                return url
            }
        }
        return nil
    }

    // MARK: – Interruption handling
    private func registerForInterruptions() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleInterruption(_:)),
            name: AVAudioSession.interruptionNotification,
            object: nil)
    }

    @objc private func handleInterruption(_ note: Notification) {
        guard let info = note.userInfo,
              let typeRaw = info[AVAudioSessionInterruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue: typeRaw) else { return }

        switch type {
        case .began:
            player?.pause()
            print(" Interruption began – paused")
        case .ended:
            if let optRaw = info[AVAudioSessionInterruptionOptionKey] as? UInt {
                let opts = AVAudioSession.InterruptionOptions(rawValue: optRaw)
                if opts.contains(.shouldResume) {
                    player?.play()
                    print(" Interruption ended – resumed")
                }
            }
        @unknown default:
            break
        }
    }

    // -----------------------------------------------------------------------
    // MARK: – Persistence (so playback survives app relaunch)
    // -----------------------------------------------------------------------

    private let lastTrackKey = "DarkMatterLastTrack"

    private func saveLastState(fileName: String) {
        UserDefaults.standard.set(fileName, forKey: lastTrackKey)
    }

    private func clearSavedState() {
        UserDefaults.standard.removeObject(forKey: lastTrackKey)
    }

    private func restoreLastState() {
        // We only restore the *name* so the UI can show the previous
        // selection. We do **not** auto‑play on launch (require user tap).
        if let saved = UserDefaults.standard.string(forKey: lastTrackKey) {
            print("Restored last track: \(saved)")
        }
    }
}
