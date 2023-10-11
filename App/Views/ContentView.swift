import SwiftUI
import RealmSwift

struct ContentView: View {
    @ObservedObject var app: RealmSwift.App
    @EnvironmentObject var errorHandler: ErrorHandler

    var body: some View {
        if let user = app.currentUser {
            // Skonfiguruj konfigurację tak, aby użytkownik początkowo subskrybował swoje własne zadania
            let config = user.flexibleSyncConfiguration(initialSubscriptions: { subs in
                subs.remove(named: Constants.allItems)
              
              
                if let _ = subs.first(named: Constants.myItems) {
                    // Znaleziono istniejącą subskrypcję – nic nie rób
                    return
                } else {
                    // Brak subskrypcji — utwórz ją
                    subs.append(QuerySubscription<Item>(name: Constants.myItems) {
                        $0.owner_id == user.id
                    })
                }
              
              if let _ = subs.first(named: Constants.exercise) { 
                return
              } else { 
                subs.append(QuerySubscription<Exercise>(name: Constants.exercise)) 
              }              
              
              
              
            })
            OpenRealmView(user: user)
                // Zapisz konfigurację w środowisku, która będzie otwierana w następnym widoku
                .environment(\.realmConfiguration, config)
        } else {
            // Jeśli nie jest zalogowany żaden użytkownik, pokaż widok logowania.
            LoginView()
        }
    }
}
