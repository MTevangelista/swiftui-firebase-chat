import SwiftUI

struct MainView: View {
    @State private var selection = 0
    
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        TabView(selection: $selection) {
            viewModel.messagesView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Messages")
                }.tag(0)
            
            Text("Settings View")
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }.tag(1)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            MainView(viewModel: MainViewModel())
                .preferredColorScheme($0)
        }
    }
}
