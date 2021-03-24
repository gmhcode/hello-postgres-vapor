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

struct CreateReview: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("reviews")
            .id()
            .field("title", .string)
            .field("body", .string)
            // foreign Key... movie_id referencesV the "id" column in the "movies" table
            .field("movie_id", .uuid, .references("movies", "id"))
            .create()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("reviews").delete()
    }
}
