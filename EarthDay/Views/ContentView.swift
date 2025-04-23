//
//  ContentView.swift
//  EarthDay
//
//  Created by Saverio Negro on 22/04/25.
//

import SwiftUI

struct ContentView: View {
    
    let dateChoices = ["1","2","3","4","5","6","7","8","9","10","11","12","1",
                       "3","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","2",
                       "9","30"]
    @State private var selectedDay = "1"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                Image(systemName: "globe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
                    .foregroundStyle(.gray)
                
                Text("What day in April is Earth Day?")
                    .font(.extraLargeTitle2)
                    .foregroundStyle(.gray)
                
                Picker("Select a Day", selection: $selectedDay) {
                    ForEach(dateChoices, id: \.self) { dateChoice in
                        Text(dateChoice)
                    }
                }
                
                NavigationLink("Check Your Work") {
                    if selectedDay == "22" {
                        CorrectView()
                    } else {
                        IncorrectView()
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
