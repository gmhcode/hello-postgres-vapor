//
//  File.swift
//  
//
//  Created by Greg Hughes on 3/24/21.
//

import Foundation
import Fluent
import Vapor
//This is the Table
final class Movie: Model, Content {
    static let schema = "movies"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    init() {}
    
    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
}
