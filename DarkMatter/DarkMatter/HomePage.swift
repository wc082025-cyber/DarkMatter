//
//  HomePage.swift
//  DarkMatter
//
//  Created by Chris Wahlberg on 07/01/2026.
//

import SwiftUI

struct HomePage: View {
    // One shared view‑model for the whole app
    @StateObject private var vm = PlayerViewModel()
    
    //MARK: fallback track
    
    private let fallbackTrack = Track(name: "Breathing Spears ",
    fileName: "BreathingSpears")
        
    
    var body: some View {
        

            NavigationStack {
                
                ZStack {
                    Color(#colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1411764706, alpha: 1))
                            .ignoresSafeArea()
                
                
                
                VStack(spacing: 10) {
                    
                    //MARK: Navlink to settings
                    NavigationLink(destination: SettingsView()){
                            HStack {
                                Image(systemName: "gearshape.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.orange.opacity(0.7))
                                    .padding(10)
                                    .glassEffect(.clear)
                                Text("")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                   
                                    .foregroundColor(.orange)
                            }
                        }
                        .position(x: 350, y: 20)
                    
                    // ---------- Header ----------
                    
                    Text("Dark Matter Audio")
                    
                        .font(.largeTitle.bold())
                        .foregroundColor(.black.opacity(0.8))
                        .padding(15)
                        .glassEffect(.clear.tint(.mint.opacity(0.7)))
                                    
                            
                         
                        
                       
                  
                    
                    Image(systemName: "waveform.path.ecg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    
                        .foregroundColor( .orange.opacity(0.7))
                    
                    
                
                    

                    //MARK: ---------- Card that navigates  ----------
                    
                    //MARK: synthetic matter link
                    
                    NavigationLink(destination: SyntheticMatter(viewModel: vm)) {
                        cardView(label: "Synthetic Matter")
                    }
                    
                    //MARK: Organic matter link
                    
                    NavigationLink(destination: OrganicMatter(viewModel: vm)) {
                        cardView(label: "Organic Matter")
                    }
                    
                    //MARK: White matter link
                    
                    NavigationLink(destination: WhiteMatter(viewModel: vm)) {
                        cardView(label: "White Matter")
                    }
                    
                    
                    
                    //MARK:  Master volume slider
                    VStack {
                  /*      Text("Master Volume")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 40)
                                .fill(Color.purple.opacity(0.1))
                                        
                                .glassEffect(.clear.tint(.purple.opacity(0.1)))
                            ) */
                       
                        
                        Slider(value: $vm.volume, in: 0...1)
                            .accentColor(.teal)
                            .opacity(0.6)
                    }
                    .padding(.horizontal, 20) // slider padding
                    
            //MARK: Master play/pause Button
                    Button(action: {
                        if vm.isPlaying {
                            // Something is playing → stop it.
                            vm.stopPlayback()
                        } else {
                            // Nothing playing → resume the *last* track if we have one,
                            // otherwise fall back to the safe default.
                            let trackToPlay = vm.lastTrackPlayed ?? fallbackTrack
                            vm.togglePlay(track: trackToPlay)
                        }
                    }) {
                        Image(systemName: vm.isPlaying ? "pause.circle.fill"
                                                       : "play.circle.fill")
                        
                        
                            .font(.system(size: 80))
                            .foregroundColor(vm.isPlaying ? .green : .orange)
                            .opacity(0.7)
                            .padding(10)
                   
                    }

                }
                .padding()
                    
                    
                    
             
            }
      
        }
        
    }
    
    
    // MARK: – Reusable purple card view
    @ViewBuilder
    private func cardView(label: String) -> some View {
        HStack {
            Image(systemName: "waveform")
                
                .font(.title2.bold())
                .foregroundColor(.black)
                .opacity(0.8)
            
                
            
            Text(label)
                .font(.title2.bold())
                .foregroundColor(.black)
                .opacity(0.8)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(10)
        .frame(maxWidth: 500, minHeight: 40)
        .background(
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.mint.opacity(0.5))
            
        )
        
        .padding(.horizontal, 0)
    }
        
}

// MARK: – Preview
#Preview {
    HomePage()
}
