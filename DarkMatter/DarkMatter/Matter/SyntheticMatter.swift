//
//  SyntheticMatter.swift
//  DarkMatter
//
//  Created by Chris Wahlberg on 08/01/2026.
//

import SwiftUI

// MARK: – Tracks for this screen
private let syntheticTracks: [Track] = [
    Track(name: "Analog Soundscape", fileName: "AnalogSoundscapeShort"),
    Track(name: "Claustrophobia",      fileName: "RumblingClaustrophobia"),
    Track(name: " Escape",      fileName: "Escape")
]

// MARK: – Main view
public struct SyntheticMatter: View {

    // Receive the shared view‑model from HomePage
    @ObservedObject var viewModel: PlayerViewModel

    public var body: some View {
        
        ZStack {
            
                Color(#colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1411764706, alpha: 1))
                        .ignoresSafeArea()
        
        
        ScrollView {
            VStack(spacing: 10) {
                // ---------- Header ----------
                Text("Synthetic Matter")
                    .font(.largeTitle.bold())
                    .foregroundColor(.black.opacity(0.8))
                    .padding(20)
                    .glassEffect(.clear.tint(.mint.opacity(0.7)))
                    .padding(.vertical, 40)
                // Dark Matter Logo
             /*       .padding(10)
                Image(systemName: "waveform.path.ecg")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.orange)
                    .padding(10)
                    .background(Circle()) */
                
                // ---------- List of tracks ----------
                ForEach(syntheticTracks) { track in
                    TrackRow(
                        track: track,
                        // The toggle is “on” when this track’s UUID matches the global one.
                        isPlaying: viewModel.currentTrackID == track.id,
                        toggleAction: { viewModel.togglePlay(track: track) }
                    )
                }
                
                // ---------- Volume slider (bottom of this page) ----------
                VStack {
                   /* Text("Master Volume")
                        .font(.title3.bold())
                        .foregroundColor(Color(.gray))
                        .padding(10)
                        .frame(width: 200)
                        .background(RoundedRectangle(cornerRadius: 40)
                            .fill(Color.purple.opacity(0.1))
                                    
                            .glassEffect(.clear.tint(.purple.opacity(0.1)))
                         
                        )
                        .padding(10)*/
                    Slider(value: $viewModel.volume, in: 0...1)
                        .accentColor(.mint)
                        .opacity(0.6)
                    
                }
                .padding(.vertical, 40)
                .padding(.horizontal, 30)
                
                Spacer(minLength: 40)
            }
        }
            .padding()
        }
        // When the user navigates away, stop playback and clear the state.
        /*.onDisappear {
            viewModel.stopPlayback()
        }*/ //
    }
}

// -------------------------------------------------------------------
// MARK: – EmptyToggleStyle (iOS‑only) – hides the default switch
// -------------------------------------------------------------------
/*struct EmptyToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(Rectangle())
            .onTapGesture { configuration.isOn.toggle() }
    }
}*/

// -------------------------------------------------------------------
// MARK: – Row view for a single track (generic Toggle<Label>)
// -------------------------------------------------------------------
private struct TrackRow: View {
    let track: Track
    let isPlaying: Bool
    let toggleAction: () -> Void

    var body: some View {
        // Generic Toggle – we hide the default iOS switch.
        Toggle(isOn: .constant(isPlaying)) {
            HStack {
                Image(systemName: "gauge.with.dots.needle.67percent")
                    .font(.system(size: 30))
                    
                Text(track.name)
                    .font(.title2.bold())

                Spacer()

                Button(action: toggleAction) {
                    Image(systemName: isPlaying ? "pause.fill"
                                                : "play.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(isPlaying ? .green : .orange)
                }
            }
        }
        .toggleStyle(EmptyToggleStyle())   // hides the built‑in switch
        
        .padding(.vertical, 4)
       
        .padding(.horizontal, 10)
        .foregroundColor(Color(.black))
        .opacity(0.8)
       
        .background(
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.mint.opacity(0.5))
            
        )
        
    }
}

// MARK: – Preview
#Preview {
    // For preview we create a temporary view‑model.
    SyntheticMatter(viewModel: PlayerViewModel())
}
