import SwiftUI
import RealmSwift

/// Wyloguj się ze zsynchronizowanego obszaru.  Powoduje powrót użytkownika do ekranu logowania/rejestracji.
struct LogoutButton: View {
  @State var isLoggingOut = false
  @State var error: Error?
  @State var errorMessage: ErrorMessage? = nil
  
  var body: some View {
    if isLoggingOut {
      ProgressView()
    }
    Button("Log Out") {
      guard let user = app.currentUser else {
        return
      }
      isLoggingOut = true
      Task {
        await logout(user: user)
        // Inne widoki obserwują aplikację i ją wykryją
        // że bieżący użytkownik się zmienił.  Nie ma tu nic więcej do roboty.
        isLoggingOut = false
      }
    }.disabled(app.currentUser == nil || isLoggingOut)
    // Pokaż alert, jeśli podczas wylogowania wystąpi błąd
      .alert(item: $errorMessage) { errorMessage in
        Alert(
          title: Text("Failed to log out"),
          message: Text(errorMessage.errorText),
          dismissButton: .cancel()
        )
      }
  }
  
  /// Asynchronicznie wyloguj użytkownika lub wyświetl alert z błędem, jeśli wylogowanie się nie powiedzie.
  func logout(user: User) async {
    do {
      try await user.logOut()
      print("Successfully logged user out")
    } catch {
      print("Failed to log user out: \(error.localizedDescription)")
      // Alert SwiftUI wymaga, aby wyświetlany element był możliwy do zidentyfikowania.
      // Opcjonalny błąd nie jest możliwy do zidentyfikowania.
      // Zapisz błąd jako tekst błędu w naszej strukturze Identible ErrorMessage,
      // które możemy wyświetlić w alercie.
      self.errorMessage = ErrorMessage(errorText: error.localizedDescription)
    }
  }
}

struct ErrorMessage: Identifiable {
  let id = UUID()
  let errorText: String
}


#Preview {
  LogoutButton(isLoggingOut: false, error: nil, errorMessage: nil)
}
