//
//  CustomNavigationBar.swift
//  FriendFace day 61 v2
//
//  Created by Marjo Salo on 29/04/2021.
//

import SwiftUI

struct CustomNavigationBar: ViewModifier {
    init() {
        let barAppearance = UINavigationBarAppearance()
        barAppearance.configureWithOpaqueBackground()
        barAppearance.backgroundColor = UIColor(#colorLiteral(red: 0.6028393115, green: 0.8309406726, blue: 0.8309406726, alpha: 1))
        barAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        barAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().scrollEdgeAppearance = barAppearance
        UINavigationBar.appearance().standardAppearance = barAppearance
        UINavigationBar.appearance().tintColor = .white
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func coloredNavigationBar() -> some View {
        self.modifier(CustomNavigationBar())
    }
}
