import SwiftUI

@main
struct iOS_Assessment_ElmApp: App {
    @StateObject private var viewModel = LoginViewModel()
    @State private var selectedTab = 0
    
    var body: some Scene {
        WindowGroup {
            if viewModel.isLoggedIn {
                ContentView(selectedTab: $selectedTab)
                    .environmentObject(viewModel)  
            } else {
                SignInView(viewModel: viewModel)
            }
        }
    }
}
