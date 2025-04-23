//
//  RotationAnimationService.swift
//  EarthDay
//
//  Created by Saverio Negro on 23/04/25.
//

import SwiftUI
import Combine

@Observable
class RotationAnimationService {
    
    var timeInterval: TimeInterval
    let publisher: Publishers.Autoconnect<Timer.TimerPublisher>
    
    init(every timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
        
        publisher = Timer.publish(every: timeInterval, on: .main, in: .common).autoconnect()
    }
}
