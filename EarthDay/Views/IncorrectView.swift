//
//  IncorrectView.swift
//  EarthDay
//
//  Created by Saverio Negro on 22/04/25.
//

import SwiftUI

struct IncorrectView: View {
    var body: some View {
        VStack(spacing: 50) {
            Image(systemName: "globe")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300)
                .foregroundStyle(.green)
            
            Text("Oops! That's not correct!")
                .font(.extraLargeTitle2)
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    IncorrectView()
}
