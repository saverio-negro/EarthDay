//
//  CorrectView.swift
//  EarthDay
//
//  Created by Saverio Negro on 22/04/25.
//

import SwiftUI
import RealityKit

struct CorrectView: View {
    
    @State private var rotation: Angle = .zero
    
    var body: some View {
        VStack(spacing: 50) {
            
        #if os(visionOS)
            Model3D(named: "Earth_Day") { model in
                model
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .rotation3DEffect(rotation, axis: .y)

        #else
            Image(systemName: "globe")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300)
                .foregroundStyle(.green)
            
            #if os(visionOS)
                .offset(z: 200)
            #endif
        #endif
            
            Text("Good job! That's correct!")
                .font(.extraLargeTitle2)
                .foregroundStyle(.green)
        }
        .padding()
        .onAppear {
            _ = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                
                rotation.degrees += 1
                
                if rotation.degrees >= 360 {
                    timer.invalidate()
                }
            }
        }
    }
}

#Preview {
    CorrectView()
}
