//
//  Settings.swift
//  DarkMatter
//
//  Created by Chris Wahlberg on 16/01/2026.
//

import SwiftUI

struct SettingsView: View {
    private let eMail = "chris.wberg@protonmail.com"
    
    private let systemName = "envelope.fill"
    
    var body: some View {
        ZStack{ //ZStack 1
            Color(#colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1411764706, alpha: 1))
                    .ignoresSafeArea()
            
            VStack{ // VStack 1
                
                Text("About Dark Matter")
                    .font(.largeTitle.bold())
                    .foregroundColor(.black.opacity(0.8))
                    .padding(15)
                    .glassEffect(.clear.tint(.mint.opacity(0.7)))
                
                    .padding(10)
                Spacer()
                
                
                Text("""
Relaxation, focusing, zoning out

Dark Matter could be your escape
from all the distractions around

Listen in, plug out 





Version 0.1

Copyright © 2026 Chris Wahlberg

""")
                
                
                .font(.system(size: 15).bold())
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(15)
                
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.mint.opacity(0.5))
                            .frame(width: 300)
                )
                    .frame(maxWidth: .infinity)
                Spacer()
                
                Image(systemName: systemName)
                    .font(.title.bold())
                    .padding(20)
                    .background(
                        Circle()
                            .fill(Color.mint.opacity(0.5)))
                    
                    
                    
                    
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(15)
                
               
                
                
                HStack{// HStack 1
                    
                 
                    
                 
                    
                    
                    
                }//HStack 1
            }//VStack 1
        }//ZStack 1
    }
}
   
#Preview {
    SettingsView()
}
