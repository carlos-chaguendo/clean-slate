//
//  ContentView.swift
//  CleanSlate
//
//  Created by Carlos Andres Chaguendo Sanchez on 9/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var controller = VoiceOverViewModel()
    
    var body: some View {
        Button("Voice Over", action: controller.toggleVoiceOver)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
