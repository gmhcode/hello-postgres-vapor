//
//  File.swift
//  
//
//  Created by Greg Hughes on 3/25/21.
//

import Foundation
import Vapor
import Fluent
final class ReviewsController {
    func create(_ req: Request) throws -> EventLoopFuture<Review> {
        let review = try req.content.decode(Review.self)
        return review.save(on: req.db).map { review }
    }
    
    func getByMovieId(_ req: Request) throws -> EventLoopFuture<[Review]> {
        guard let movieId = req.parameters.get("movieId", as: UUID.self) else {throw Abort(.notFound)}
            //1. start asking database
        return Review.query(on: req.db)
            //2. only get the reviews whos movie id matches the movieID
            .filter(\.$movie.$id, .equal, movieId)
            //3. also get the whole movie object
            .with(\.$movie)
            .all()
    }
}
