//
//  RotationAnimationAroundYAxis.swift
//  EarthDay
//
//  Created by Saverio Negro on 23/04/25.
//

import SwiftUI
import Combine

extension View {
    func rotationAnimationAroundYAxis(initialAngle: Angle, deltaAngle: Angle, maximumAngle: Double?, every: TimeInterval) -> some View {
        self.modifier(
            RotationAnimationAroundYAxis(
                initialRotation: initialAngle,
                deltaRotation: deltaAngle,
                maximumRotation: maximumAngle,
                every: every
            )
        )
    }
}

enum FlowState {
    case idle
    case rotating
}

struct RotationAnimationAroundYAxis: ViewModifier {
    
    @State private var rotation: Angle
    @State private var initialRotation: Angle
    @State private var deltaRotation: Angle
    @State private var maximumRotation: Double?
    @State private var every: TimeInterval
    @State private var cancellableSubscriber: Cancellable?
    @State private var flowState: FlowState
    
    init(initialRotation: Angle = .zero, deltaRotation: Angle, maximumRotation: Double? = nil, every timeInterval: TimeInterval, flowState: FlowState = .rotating) {
        self.initialRotation = initialRotation
        self.deltaRotation = deltaRotation
        self.maximumRotation = maximumRotation
        self.every = timeInterval
        self.flowState = flowState
        
        // Initialize current rotation to initial rotation
        self.rotation = initialRotation
    }
    
    func bindTimerPublisher() {
        let rotationService = RotationAnimationService(every: every)
        
        cancellableSubscriber = rotationService.publisher
            .scan(initialRotation.degrees) { rotationDegrees, _ in
                return rotationDegrees + deltaRotation.degrees
            }
            .map { value in
                Angle(degrees: value)
            }
            .assign(to: \.rotation, on: self)
    }
    
    func body(content: Content) -> some View {
        
        return content
            .rotation3DEffect(rotation, axis: (x: 0, y: 1, z: 0))
            .onChange(of: rotation) {
                if let maximumRotation = maximumRotation {
                    if rotation.degrees >= maximumRotation {
                        flowState = .idle
                    } else {
                        flowState = .rotating
                    }
                } else {
                    flowState = .rotating
                }
            }
            .onChange(of: flowState) { _, newValue in
                switch newValue {
                case .idle:
                    cancellableSubscriber = nil
                case .rotating:
                    guard cancellableSubscriber == nil else { return }
                    
                    bindTimerPublisher()
                }
            }
            .onAppear {
                switch flowState {
                case .idle:
                    cancellableSubscriber = nil
                case .rotating:
                    bindTimerPublisher()
                }
            }
    }
}
