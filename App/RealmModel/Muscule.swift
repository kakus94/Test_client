//
//  Muscule.swift
//  App
//
//  Created by Kamil Karpiak on 11/10/2023.
//

import Foundation
import RealmSwift

enum MuscleGroup: Int, PersistableEnum, CaseIterable {
  case chest = 1        // klatka piersiowa
  case back = 2         // plecy
  case triceps = 3      // triceps
  case shoulders = 4    // barki
  case biceps = 5       // biceps
  case forearms = 6     // przedramiona
  case quadriceps = 7   // czworoglowe
  case doubleHeaded = 8 // dwuglowe
  case sweets = 9       // posladki
  case adductors = 10   // przywodziciele
  case calves = 11      // lydki
  case belly = 12       // brzuch
}

extension MuscleGroup {
  var name: String {
    switch self {
    case .chest:
      return "klatka piersiowa"
    case .back:
      return "plecy"
    case .triceps:
      return "triceps"
    case .shoulders:
      return "barki"
    case .biceps:
      return "biceps"
    case .forearms:
      return "przedramiona"
    case .quadriceps:
      return "czworoglowe"
    case .doubleHeaded:
      return "dwuglowe"
    case .sweets:
      return "posladki"
    case .adductors:
      return "przywodziciele"
    case .calves:
      return "lydki"
    case .belly:
      return "brzuch"
    }
  }
  
  
  var include: [Muscles] {
    switch self {
    case .chest:
      return [.upperChest, .middleChest, .lowerChest, .serratusAnteriorMuscle]
    case .back:
      return [.quadrilateralUpper, .medialTriceps, .lowerTrapezius, .latissimusDorsi, .infraspinatus, .smallerRounds, .roundedBigger, .erectorSpinae]
    case .triceps:
      return [.longHeadTriceps, .lateralTriceps, . medialTriceps]
    case .shoulders:
      return [.frontPartShoulder, .middlePartShoulder, .backPartShoulder]
    case .biceps:
      return [.longHeadTwoHeadedArm, .shortHeadTwoHeadedArm]
    case .forearms:
      return [.brachioradialMuscle, .forearmFlexorMuscles, .forearmExtensorMuscles]
    case .quadriceps:
      return [.vastusMedialis, .vastusIntermedius, .rectusFemoris]
    case .doubleHeaded:
      return [.semitendinosus, .semimembranosus, .bicepsFemoris]
    case .sweets:
      return [.gluteusMedius, .gluteusMaximus]
    case .adductors:
      return [.greatLeader, .longLeader, .slenderLeader, .comb, .tailor]
    case .calves:
      return [.tibial, .soleus, .gastrocnemius]
    case .belly:
      return [.slantingStorm, .topBelly, .lowerBelly]
    }
  }
  
}


enum Muscles: Int, PersistableEnum, CaseIterable {
  // Chest Muscles
 case upperChest   = 1            // gora klatki piersiowej
  case middleChest = 2            // srodek klatki piersiowej
  case lowerChest  = 3            // dol klatki piersiowej
  case serratusAnteriorMuscle = 4 // miesien zebaty przedni
  
  // Back Muscles
  case quadrilateralUpper = 5   // czworoboczny gorny
  case medialTrapezius    = 6   // czworoboczny przysrodkowy
  case lowerTrapezius     = 7   // czworoboczny dolny
  case latissimusDorsi    = 8   // najszerszy grzbietu
  case infraspinatus      = 9   // podgrzebieniowy
  case smallerRounds      = 10  // obly mniejszy
  case roundedBigger      = 11  // obly wiekszy
  case erectorSpinae      = 12  // prostownik grzbietu
  
  // triceps Muscles
  case longHeadTriceps  = 13 // dluga glowa miesnia trojglowego
  case lateralTriceps   = 14 // boczna glowa miesnia trojglowego
  case medialTriceps    = 15 // przyśrodkowa miesnia trojglowego
  
  // shoulders Muscule
  case frontPartShoulder  = 16 // przedni część barku
  case middlePartShoulder = 17 // srodkowa część barku
  case backPartShoulder   = 18 // tylnia część barku
  
  // biceps Muscule
  case longHeadTwoHeadedArm   = 19 // dluga glowa dwuglowego ramienia
  case shortHeadTwoHeadedArm  = 20 // krótka glowa dwuglowego ramienia
  
  // forearms Muscule
  case brachioradialMuscle    = 21 // miesien ramienno promieniowy
  case forearmFlexorMuscles   = 22 // miesien zginacze przedramienia
  case forearmExtensorMuscles = 23 // miesien prostowniki przedramienia
  
  // quadriceps Muscule
  case vastusMedialis    = 24 // miesien obszerny  przysrodkowy
  case vastusIntermedius = 25 // miesien obszerny posredni
  case rectusFemoris     = 26 // miesien prosty uda
  
  // doubleHeaded Muscule
  case semimembranosus  = 27 // miesien półbłoniasty
  case semitendinosus   = 28 // miesien półsciegnisty
  case bicepsFemoris    = 29 // miesien dwuglowy uda
  
  // ass Muscule
  case gluteusMaximus = 30 // pośladowy wielki
  case gluteusMedius  = 31 // pośladkowy sredni
  
  // adductors Muscule
  case greatLeader    = 32 // przewodzicel wielki
  case longLeader     = 33 // przewodziciel dlugi
  case slenderLeader  = 34 // przewodziciel smukly
  case comb           = 35 // grzebieniowy
  case tailor         = 36 // krawiecki
  
  // calves Muscule
  case tibial         = 37 // piszczelowy
  case soleus         = 38 // płaszczkowaty
  case gastrocnemius  = 39 // brzuchaty łydki
  
  // belly Muscule
  case slantingStorm  = 40 // skosne burzucha
  case topBelly       = 41 // gora brzucha
  case lowerBelly     = 42 // dol brzucha
  
}

extension Muscles {
  var name: String {
    switch self {
    case .upperChest:
      return "Gora klatki piersiowej"
    case .middleChest:
      return "Środek klatki piersiowej"
    case .lowerChest:
      return "Dól klatki piersiowej"
    case .serratusAnteriorMuscle:
      return "Zebaty przedni"
      
      
    case .quadrilateralUpper:
      return "Czworoboczny gorny"
    case .medialTrapezius:
      return "Czworoboczny przyśrodkowy"
    case .lowerTrapezius:
      return "Czworoboczny dolny"
    case .latissimusDorsi:
      return "Najszerszy grzbietu"
    case .infraspinatus:
      return "Podgrzebieniowy"
    case .smallerRounds:
      return "Obły mniejszy"
    case .roundedBigger:
      return "Obły wiekszy"
    case .erectorSpinae:
      return "prostownik grzbietu"
      
      
    case .longHeadTriceps:
      return "Długa głowa mieśnia trojglowego"
    case .lateralTriceps:
      return "Boczna glowa miesnia trojglowego"
    case .medialTriceps:
      return "przyśrodkowa miesnia trojglowego"
      
      
    case .frontPartShoulder:
      return "Przedni część barku"
    case .middlePartShoulder:
      return "Środkowa część barku"
    case .backPartShoulder:
      return "Tylnia część barku"
      
      
    case .longHeadTwoHeadedArm:
      return "Długa glowa dwuglowego ramienia"
    case .shortHeadTwoHeadedArm:
      return "krótka glowa dwuglowego ramienia"
      
      
    case .brachioradialMuscle:
      return "miesien ramienno promieniowy"
    case .forearmFlexorMuscles:
      return "miesien zginacze przedramienia"
    case .forearmExtensorMuscles:
      return "miesien prostowniki przedramienia"
      
      
    case .vastusMedialis:
      return "miesien obszerny przysrodkowy"
    case .vastusIntermedius:
      return "miesien obszerny posredni"
    case .rectusFemoris:
      return "miesien prosty uda"
      
      
    case .semimembranosus:
      return "miesien półbłoniasty"
    case .semitendinosus:
      return "miesien półsciegnisty"
    case .bicepsFemoris:
      return "miesien dwuglowy uda"
      
      
    case .gluteusMaximus:
      return "pośladowy wielki"
    case .gluteusMedius:
      return "pośladkowy sredni"
      
      
    case .greatLeader:
      return "przewodzicel wielki"
    case .longLeader:
      return "przewodziciel dlugi"
    case .slenderLeader:
      return "przewodziciel smukly"
    case .comb:
      return "grzebieniowy"
    case .tailor:
      return "krawiecki"
      
      
    case .tibial:
      return "piszczelowy"
    case .soleus:
      return "płaszczkowaty"
    case .gastrocnemius:
      return "brzuchaty łydki"
      
      
    case .slantingStorm:
      return "skosne burzucha"
    case .topBelly:
      return "gora brzucha"
    case .lowerBelly:
      return "dol brzucha"
    }
  }
}


enum TypeLoad: Int, PersistableEnum, CaseIterable {
  case bodyWeight = 0
  case weight = 1
  case resilience = 2
  case resistanceBand = 3
  
  
  var name: String { 
    switch self {
      case .bodyWeight:
        return "Masa ciała"
      case .weight:
        return " Ciężar"
      case .resilience:
        return "Wytrzymalość"
      case .resistanceBand:
        return "Gumy"
    }
  }
}

