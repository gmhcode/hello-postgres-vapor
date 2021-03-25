//
//  File.swift
//  
//
//  Created by Greg Hughes on 3/25/21.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct AddPosterColumnToMovies: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies")
            .field("poster", .string)
            .update()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies")
            .deleteField("poster")
            .delete()
    }
}
