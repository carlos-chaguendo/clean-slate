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
        Button("Voice Over", action: controller.toggleVoiceOver)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
