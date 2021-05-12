//
//  Model.swift
//  NestedTableView
//
//  Created by Pavan Kumar on 05/02/21.
//

import Foundation

struct Goal {
    let title: String
    let Actions: [Action]
}

struct Action {
    let title: String
}


let sample = [
    Goal(title: "Learn iOS",
         Actions: [
            Action(title: "Learn Swift"),
            Action(title: "Go Throught WWDC Videos")
         ]),
    Goal(title: "Learn Node.JS",
         Actions: [
            Action(title: "Learn JavaScript"),
            Action(title: "Learn Node")
         ])
]
