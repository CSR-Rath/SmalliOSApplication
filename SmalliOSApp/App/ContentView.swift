//
//  ContentView.swift
//  SmalliOSApp
//
//  Created by Rath! on 14/10/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()
    
    init() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .black
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black,
                                          .font: UIFont.systemFont(ofSize: 17, weight: .bold)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black,
                                               .font: UIFont.systemFont(ofSize: 32, weight: .bold)]
        appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            UserListView(viewModel: viewModel)
        }
    }
    
}


#Preview {
    ContentView()
}
