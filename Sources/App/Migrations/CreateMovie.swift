//
//  File.swift
//  
//
//  Created by Greg Hughes on 3/24/21.
//

import Foundation
import Fluent
import FluentPostgresDriver
//Creates Tables
struct CreateMovie: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies")
            .id()
            .field("title", . string)
            .create()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies").delete()
    }
}
