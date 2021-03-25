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
    
    @Field(key: "poster")
    var poster: String?
    
    // hasMany - This is saying there will be a property on all the children called "movie"
    @Children(for: \.$movie)
    var reviews: [Review]
    
    //manyToMany - useing a movie, get all the actors a for that movie
    @Siblings(through: MovieActor.self, from: \.$movie, to: \.$actor)
    var actors: [Actor]
    
    
    
    init() {}
    
    init(id: UUID? = nil, title: String, poster: String) {
        self.id = id
        self.title = title
        self.poster = poster
    }
}
