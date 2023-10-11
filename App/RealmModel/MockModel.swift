//
//  MockModel.swift
//  App
//
//  Created by Kamil Karpiak on 11/10/2023.
//

import Foundation

extension TreninigPlan_V2 { 
  
  static func mockModel() -> TreninigPlan_V2 { 
    .init(name: "Trening Name", desc: "Opis treningu", duration: "1:21", superSeria: [
      .init(exercises: [
        .init(id: "21212dsadada12da", name: "Wycisanie Hantli poziomo", seria: [
          .init(lp: 1, weight: 21, numberRepet: 21),
          .init(lp: 2, weight: 21, numberRepet: 12),
          .init(lp: 1, weight: 21, numberRepet: 21),
          .init(lp: 2, weight: 21, numberRepet: 12)
        ]),
        .init(id: "sa12sae1da", name: "Wycisanie Hantli dodatnio", seria: [
          .init(lp: 1, weight: 21, numberRepet: 21),
          .init(lp: 2, weight: 21, numberRepet: 12),
          .init(lp: 1, weight: 21, numberRepet: 21),
          .init(lp: 2, weight: 21, numberRepet: 12)
        ])
      ]),
      .init(exercises: [
        .init(id: "12sada212", name: "Wycisanie Hantli ujemne", seria: [
          .init(lp: 1, weight: 21, numberRepet: 21),
          .init(lp: 2, weight: 21, numberRepet: 12),
          .init(lp: 1, weight: 21, numberRepet: 21),
          .init(lp: 2, weight: 21, numberRepet: 12)
        ])
      ])
    ])
  }  
  
  static func mockData() -> Data { 
    "{\"name\":\"Trening Name\",\"duration\":\"1:21\",\"superSeria\":[{\"exercises\":[{\"name\":\"Wycisanie Hantli poziomo\",\"seria\":[{\"lp\":1,\"weight\":21,\"numberRepet\":21},{\"weight\":21,\"numberRepet\":12,\"lp\":2},{\"weight\":21,\"lp\":1,\"numberRepet\":21},{\"numberRepet\":12,\"weight\":21,\"lp\":2}],\"id\":\"21212dsadada12da\"},{\"seria\":[{\"weight\":21,\"numberRepet\":21,\"lp\":1},{\"weight\":21,\"numberRepet\":12,\"lp\":2},{\"numberRepet\":21,\"lp\":1,\"weight\":21},{\"numberRepet\":12,\"weight\":21,\"lp\":2}],\"name\":\"Wycisanie Hantli dodatnio\",\"id\":\"sa12sae1da\"}]},{\"exercises\":[{\"seria\":[{\"numberRepet\":21,\"weight\":21,\"lp\":1},{\"numberRepet\":12,\"lp\":2,\"weight\":21},{\"weight\":21,\"lp\":1,\"numberRepet\":21},{\"weight\":21,\"numberRepet\":12,\"lp\":2}],\"id\":\"12sada212\",\"name\":\"Wycisanie Hantli ujemne\"}]}],\"desc\":\"Opis treningu\"}".data(using: .utf8)!
  }
  
}
