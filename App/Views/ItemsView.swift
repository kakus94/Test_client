import SwiftUI
import RealmSwift

/// Use views to see a list of all Items, add or delete Items, or logout.
struct ItemsView: View {
    var leadingBarButton: AnyView?
    // ObservedResults jest kolekcją modyfikowalną;  tu jest
     // wszystkie obiekty Item w dziedzinie.
     // Możesz dodawać lub usuwać zadania bezpośrednio z kolekcji.
    @ObservedResults(Item.self) var item
    @EnvironmentObject var errorHandler: ErrorHandler

    @State var itemSummary = ""
    @State var user: User
    @State var isInCreateItemView = false
    @State var showOfflineNote = false
    @Binding var showMyItems: Bool
    @Binding var isInOfflineMode: Bool

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if isInCreateItemView {
                        CreateItemView(isInCreateItemView: $isInCreateItemView, user: user)
                    }
                    else {
                        Toggle("Show Only My Tasks", isOn: $showMyItems).padding()
                        ItemList()
                    }
                }
                .navigationBarItems(leading: self.leadingBarButton,
                                    trailing: HStack {
                    Button {
                        if !isInOfflineMode {
                            showOfflineNote = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                self.showOfflineNote = false
                            }
                        }
                        isInOfflineMode = !isInOfflineMode
                        
                    } label: {
                        isInOfflineMode ? Image(systemName: "wifi.slash") : Image(systemName: "wifi")
                    }
                    Button {
                        isInCreateItemView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                })
                if showOfflineNote {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(Color(UIColor.lightGray))
                        .frame(width: 250, height: 150, alignment: .bottom)
                        .overlay(
                            VStack {
                                Text("Now 'Offline'").font(.largeTitle)
                                Text("Switching subscriptions does not affect Realm data when sync is offline").font(.body)
                            }
                            .padding()
                            .multilineTextAlignment(.center)
                            
                        )
                }
            }
        }
    }
}
