//
//  File.swift
//  
//
//  Created by Greg Hughes on 3/24/21.
//
import Foundation
import Fluent
import FluentPostgresDriver
import Vapor

final class Review: Model, Content {
    
    static let schema = "reviews"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "body")
    var body: String
    
    // belongsTo - Review belongs to a movie
    @Parent(key: "movie_id") // FK
    var movie: Movie
    
    init() {}
    
    init(id: UUID? = nil, title: String, body: String, movieId: UUID) {
        self.id = id
        self.title = title
        self.body = body
        //pulls out the movie.id field and sets it to movieId
        self.$movie.id = movieId
    }
}
