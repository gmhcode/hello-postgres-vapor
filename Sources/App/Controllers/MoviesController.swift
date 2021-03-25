//
//  File.swift
//  
//
//  Created by Greg Hughes on 3/25/21.
//

import Foundation
import Vapor

final class MoviesController {
    
    func delete(_ req: Request)throws -> EventLoopFuture<HTTPStatus> {
        Movie.find(req.parameters.get("movieId"), on: req.db).unwrap(or: Abort(.notFound)).flatMap {
            $0.delete(on: req.db)
        }.transform(to: .ok)
    }
    
    func create(_ req: Request) throws -> EventLoopFuture<Movie> {
        let movie = try req.content.decode(Movie.self)
        return movie
            .create(on: req.db)
            .map{ movie }
    }
    
    func all(_ req: Request) throws -> EventLoopFuture<[Movie]> {
        Movie.query(on: req.db).all()
    }
}
