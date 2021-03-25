//
//  File.swift
//  
//
//  Created by Greg Hughes on 3/25/21.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateActor: Migration {
    
    //In this you describe which fields you want to move over
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("actors")
            .id()
            .field("name", .string)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("actors").delete()
    }
}
