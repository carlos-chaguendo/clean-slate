//
//  VoiceOverView.swift
//  CleanSlate
//
//  Created by Carlos Andres Chaguendo Sanchez on 9/06/22.
//

import SwiftUI

struct VoiceOverView: View {
    @StateObject var controller = VoiceOverController()
    
    var body: some View {
        List {
            Toggle("VoiceOver", isOn: $controller.isVoiceOverRunning)
//            Toggle("Captions Panel", isOn: $controller.isVoiceOverCaptionsEnabled)
            Toggle("Reduce Motion", isOn: $controller.isReduceMotionEnabled)
//            Toggle("Invert ColorsT", isOn: $controller.isInvertColorsEnabled)
        }.onChange(of: controller.isVoiceOverRunning) { _ in
            controller.toggleVoiceOver()
        }.onChange(of: controller.isVoiceOverCaptionsEnabled) { _ in
            controller.toggleVoiceOverCaptions()
        }.onChange(of: controller.isReduceMotionEnabled) { _ in
            controller.toggleReduceMotion()
        }.onChange(of: controller.isInvertColorsEnabled) { _ in
            controller.toggleInvertColors()
        }.navigationTitle("VoiceOver")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceOverView()
    }
}
