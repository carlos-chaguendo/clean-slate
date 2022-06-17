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
        }.onChange(of: controller.isVoiceOverRunning) { newValue in
            controller.toggleVoiceOver()
        }.navigationTitle("VoiceOver")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceOverView()
    }
}
