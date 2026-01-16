//
//  Track.swift
//  DarkMatter
//
//  Created by Chris Wahlberg on 09/01/2026.
//

import Foundation

/// Simple value‑type that describes a single noise track.
struct Track: Identifiable {
    let id = UUID()
    let name: String      // UI label
    let fileName: String  // Base name of the bundled audio file (no extension)
}
