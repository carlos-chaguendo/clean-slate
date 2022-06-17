//
//  MenuView.swift
//  CleanSlate
//
//  Created by Carlos Andres Chaguendo Sanchez on 9/06/22.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        List{
            NavigationLink(destination: VoiceOverView()) {
                Text("Accessibility")
            }
        }
        .navigationTitle("Settings")
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MenuView()
        }
    }
}
