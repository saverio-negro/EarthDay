//
//  CorrectView.swift
//  EarthDay
//
//  Created by Saverio Negro on 22/04/25.
//

import SwiftUI
import RealityKit

struct CorrectView: View {
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
    }
}

#Preview {
    CorrectView()
}
