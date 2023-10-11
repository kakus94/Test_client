import SwiftUI
import RealmSwift

/// Wywoływane po zakończeniu logowania.  Otwiera krainę i przechodzi do ekranu Przedmiotów.
struct OpenRealmView: View {
  @AutoOpen(appId: theAppConfig.appId, timeout: 2000) var autoOpen
  // Musimy przekazać użytkownika, abyśmy mogli ustawić user.id podczas tworzenia obiektów Item
  @State var user: User
  @State var showMyItems = true
  @State var isInOfflineMode = false
  // Configuration used to open the realm.
  @Environment(\.realmConfiguration) private var config
  
  var body: some View {
    switch autoOpen {
      case .connecting:
        // Rozpoczęcie procesu Realm.autoOpen.
        // Pokaż widok postępu.
        ProgressView()
      case .waitingForUser:
        // Oczekiwanie na zalogowanie użytkownika przed wykonaniem
        // Dziedzina.asyncOpen.
        ProgressView("Waiting for user to log in...")
      case .open(let realm):
        // Kraina została otwarta i jest gotowa do użycia.
        // Pokaż widok Elementy.
        ItemsView(leadingBarButton: AnyView(LogoutButton()), user: user, showMyItems: $showMyItems, isInOfflineMode: $isInOfflineMode)
        // showMyItems przełącza tworzenie subskrypcji
        // Gdy ta opcja jest włączona, wyświetlana jest tylko oryginalna subskrypcja – „my_items”.
        // Gdy opcja jest wyłączona, *wszystkie* elementy są pobierane do pliku
        // klient, w tym od innych użytkowników.
          .onChange(of: showMyItems) { newValue in
            let subs = realm.subscriptions
            subs.update {
              if newValue {
                subs.remove(named: Constants.allItems)
              } else {
                if subs.first(named: Constants.allItems) == nil {
                  subs.append(QuerySubscription<Item>(name: Constants.allItems))
                }
              }
            }
          }
        // isInOfflineMode symuluje sytuację bez połączenia z Internetem.
        // Chociaż synchronizacja nie jest dostępna, elementy można nadal zapisywać i odpytywać.
        // Po wznowieniu synchronizacji elementy utworzone lub zaktualizowane w trybie offline zostaną przesłane do
        // serwer i zmiany z serwera lub innych urządzeń zostaną pobrane do klienta.
          .onChange(of: isInOfflineMode) { newValue in
            let syncSession = realm.syncSession!
            newValue ? syncSession.suspend() : syncSession.resume()
          }
          .onAppear {
            if let _ = realm.subscriptions.first(named: Constants.allItems) {
              // Klient zasubskrybował wszystkie elementy z poprzedniego
              // sesja, więc odpowiednio ustaw przełącznik interfejsu użytkownika
              showMyItems = false
            }
          }
      case .progress(let progress):
        // Aktualnie trwa pobieranie domeny z serwera.
        // Pokaż widok postępu.
        ProgressView(progress)
      case .error(let error):
        // Otwarcie Królestwa nie powiodło się.
        // Pokaż widok błędu.
        ErrorView(error: error)
    }
  }
}
