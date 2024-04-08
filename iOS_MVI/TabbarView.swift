import SwiftUI

import SwiftUI

extension TabbarView {
    enum Tab: Hashable {
        case home
        case search
        case map
    }
}

struct TabbarView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            ProfileView()
                .tag(Tab.home)

            FakeEmptyView()
                .tag(Tab.search)

            FakeEmptyView()
                .tag(Tab.map)
        }
        .overlay(
            Color.white
                .edgesIgnoringSafeArea(.vertical)
                .frame(height: 80) // The height of a tab bar is default 68 points.13 is the lock bar height
                .shadow(color: Color.black.opacity(0.2), radius: 16, x: 0, y: 2)
                .overlay(
                    HStack {
                        TabBarButton(tab: .home, image: Asset.TabbarIcons.profile.imageView, selectedTab: $selectedTab)
                        Spacer()
                        TabBarButton(tab: .search, image: Asset.TabbarIcons.search.imageView, selectedTab: $selectedTab)
                        Spacer()
                        TabBarButton(tab: .map, image: Asset.TabbarIcons.map.imageView, selectedTab: $selectedTab)
                    }
                    .padding(EdgeInsets(top: 16, leading: 40, bottom: 48, trailing: 40))
                ),
            alignment: .bottom
        )
        .edgesIgnoringSafeArea(.all)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TabBarButton: View {
    let tab: TabbarView.Tab
    let image: Image
    @Binding var selectedTab: TabbarView.Tab

    var body: some View {
        Button(action: {
            selectedTab = tab
        }, label: {
            image
                .foregroundColor(selectedTab == tab ? Color.cPrimary : Color.cSecondary)
        })
    }
}

struct FakeEmptyView: View {
    var body: some View {
        VStack {}
    }
}

#Preview {
    TabbarView()
}
