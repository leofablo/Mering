//
//  metaringApp.swift
//  metaring
//
//  Created by Rinaldi on 21/05/22.
//

import SwiftUI

@main
struct metaringApp: App {
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
    }
}
