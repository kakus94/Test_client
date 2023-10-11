//
//  Model.swift
//  App
//
//  Created by Kamil Karpiak on 11/10/2023.
//

import Foundation
import RealmSwift

class AplicationUser: Object, Identifiable {
  /// Unikalny identyfikator
  @Persisted(primaryKey: true) var _id: ObjectId
  /// id urzytkownika
  @Persisted var userId: String?
  
  /// Imię i nazwisko użytkownika
  @Persisted var name:    String?  
  /// Adres e-mail użytkownika
  @Persisted var email:   String?  
  /// Wiek użytkownika
  @Persisted var age:     Int?     
  /// Płeć użytkownika
  @Persisted var gender:  String?  
  
  /// Ścieżka do profilowego zdjęcia użytkownika
  @Persisted var profilePicture: String? 
  
  /// lista zakonczonych treningow ( Historia )
  @Persisted var history:         List<TrainingHistory>
  /// Lista Trenigow urzytkownika
  @Persisted var treningPlane:    List<TrainingPlan>
  /// Pomiary ciala
  @Persisted var measurementBody: List<MeasurementBody>
}


class MeasurementBody: Object, Identifiable { 
  /// Unikalny identyfikator 
  @Persisted(primaryKey: true) var _id: ObjectId
  /// powiazany urzytkownik
  @Persisted(originProperty: "measurementBody") var userLink: LinkingObjects<AplicationUser>
  /// id urzytkownika
  @Persisted var userId: String?
  
  /// Data pomiaru
  @Persisted var date: Date    
  /// Obwód szyi w centymetrach
  @Persisted var neckCircumference:   Double?
  /// Obwód klatki piersiowej w centymetrach
  @Persisted var chestCircumference:  Double? 
  /// Obwód talii w centymetrach
  @Persisted var waistCircumference:  Double? 
  /// Obwód bioder w centymetrach
  @Persisted var hipCircumference:    Double? 
  /// Obwód bicepsa w centymetrach
  @Persisted var bicepCircumference:  Double? 
  /// Obwód uda w centymetrach
  @Persisted var thighCircumference:  Double? 
  /// Obwód łydki w centymetrach
  @Persisted var calfCircumference:   Double? 
  /// Procent tłuszczu w ciele
  @Persisted var bodyFatPercentage:   Double? 
  /// Masa mięśniowa w kilogramach
  @Persisted var muscleMass:  Double? 
  /// Waga w kilogramach
  @Persisted var weight:      Double? 
  /// Wzrost w centymetrach
  @Persisted var height:      Double?
  /// Zdjęcie przedstawiające postęp
  @Persisted var progressPhoto: Data? 
}


class Exercise: Object, Identifiable {
  /// Unikalny identyfikator 
  @Persisted(primaryKey: true) var _id: ObjectId
  
  /// nazwa cwiczenia 
  @Persisted var name: String           
  /// kategoria cwiczenia silowe, wlasnym cialem
  @Persisted var category: TypeLoad    
  /// opis
  @Persisted var desc: String  
  /// url do wideo
  @Persisted var videoURL: String?    
  /// procentowy udzial wagi ciala
  @Persisted var precentUseBodyMass: Double 
  
  /// Grupa miesniowa zaangazowana 
  @Persisted var muscleGroups:  List<MuscleGroup>
  /// Glowne miesnie 
  @Persisted var mainMuscule:   List<Muscles>
  /// Pomocnicze miesnie 
  @Persisted var secondMuscule: List<Muscles>
  /// zdjecie cwiczenia
  @Persisted var imageData: Data?
}


class  TrainingPlan: Object, Identifiable {
  /// Unikalny identyfikator planu
  @Persisted(primaryKey: true) var _id: ObjectId  
  /// powiazany urzytkownik
  @Persisted(originProperty: "treningPlane") var userLink: LinkingObjects<AplicationUser>
  /// id urzytkownika
  @Persisted var userId: String?
  
  ///Nazwa treningu
  @Persisted var name: String     
  ///Opis treningu
  @Persisted var desc: String    
  ///czas trwania
  @Persisted var duration: String   
  ///lista cwiczen zawartych w treningu
  @Persisted var exerciseList: List<Exercise>    
  ///trening w postaci Json
  @Persisted var treningPlan: String  
  ///model treningu
  var treninig: TreninigPlan_V2? 
  
  /// Przetwarza pobrany model trenigu z postaci String na Model TreningPlan 
  func prepareTrening() { 
    treninig = TreninigPlan_V2.create(data: treningPlan.data(using: .utf8))
  }
  
  
  /// Zwraca Cwiczenie zwiazane z id
  /// - Parameter id: id cwiczenia
  /// - Returns: Cwiczenie
  func getExercise(id: String) -> Exercise? { 
    exerciseList.first(where: { $0._id.stringValue == id })
  }
    
}

class TrainingHistory: Object, Identifiable {
  /// Unikalny identyfikator planu
  @Persisted(primaryKey: true) var _id: ObjectId 
  /// ID użytkownika, który wykonał trening
  @Persisted(originProperty: "history") var userLink: LinkingObjects<AplicationUser> 
  /// id urzytkownika
  @Persisted var userId: String?
  
  /// ID planu treningowego, który został wykonany
  @Persisted var TrainingPlanID: TrainingPlan? 
  /// Data wykonania treningu
  @Persisted var Date: Date    
  /// Czas trwania treningu
  @Persisted var Duration: String
  /// Spalone kalorie podczas treningu
  @Persisted var CaloriesBurned: Int    
  /// Srednie tetno 
  @Persisted var heartBit: Int                
      
}

/// przedstawia trening, uzywane podczas treningu
struct TreninigPlan_V2: Codable {  
  /// nazwa treningu
  var name: String 
  /// Opis treningu
  var desc: String
  /// średnii czas treningu
  var duration: String
  /// cwiczenia wchidzace w skalad w super serie 
  var superSeria: [SuperSeria]  
  
  
  /// Przeksztalca model na format json Data?
  /// - Returns: Data?
  func getJsonData() -> Data? { 
    try? JSONEncoder().encode(self)
  }
  
  
  init(name: String, desc: String, duration: String, superSeria: [SuperSeria]) {
    self.name = name
    self.desc = desc
    self.duration = duration
    self.superSeria = superSeria
  }
  
  
  /// Tworzy model z danych 
  /// - Parameter data: Dane przedstawiajace model
  /// - Returns: Zwraca model  TreningPlan
  static func create(data: Data?) -> Self? { 
    guard let data else { return nil }
    return try? JSONDecoder().decode(TreninigPlan_V2.self, from: data)
  }  
  
  /// Tworzy model z danych 
  /// - Parameter str: String przedstawiajacy model
  /// - Returns: Zwraca model  TreningPlan
  static func create(str: String?) -> Self? { 
    guard let data = str?.data(using: .utf8) else { return nil }
    return try? JSONDecoder().decode(TreninigPlan_V2.self, from: data)
  }    
  
}

/// Przedstawia super serie jesli zawiera tylko jeden record to traktowane jest jako pojedyncze cwiczenie 
struct SuperSeria: Codable { 
  var exercises: [ExerciseS]
}

/// Cwiczenie id
struct ExerciseS: Codable { 
  /// id przedstawia id cwiczenia 
  var id: String 
  /// nazwa cwiczenia 
  var name: String
  /// seria cwiczenia 
  var seria: [Seria]
}


/// Przedstawia serie 
struct Seria: Codable { 
  /// liczba pozadkowa
  var lp: Int
  /// Ciezar
  var weight: Double
  /// Powtorzenia
  var numberRepet: Int   
  /// czas wykonywania cwiczenia
  var timeEx: Int?
  /// czas odpoczynku 
  var restEx: Int?
  /// trudnos po cwiczeniu 
  var difficulty: Difficulty?
  /// srednie tetno serca
  var averageHeartRate: Int?
  /// spalone kalorie 
  var calories: Int?
}

enum Difficulty: Int, Codable { 
  case easy = 4, medium = 3, hard = 2, veryHard = 1, noMore = 0
}
