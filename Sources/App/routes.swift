import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    //Get
    app.get("movies") { req in
        Movie.query(on: req.db)
            //1. serves all the reviews with this movie
            .with(\.$reviews).all()
    }
    
    // /movies/id
    app.get("movies",":movieId") { req -> EventLoopFuture<Movie> in
        Movie
            .find(req.parameters.get("movieId"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    // /movies PUT - body needs to have the correct id with the updated movie
    app.put("movies"){ req -> EventLoopFuture<HTTPStatus> in
        // 1. Decode the content into movie
        let movie = try req.content.decode(Movie.self)
        
        return Movie
            //2. find the movie in the database
            .find(movie.id, on: req.db)
            //3. unwraps the find optional, aborts if nil
            .unwrap(or: Abort(.notFound))
            //4. flatMap is for async operations inside the flatMap (update)
            .flatMap {
                $0.title = movie.title
                //5. updates the DB
                return $0.update(on: req.db)
                //6. Sends the ok status
                    .transform(to: .ok)
            }
    }
    
    //Fully ASYNC update THIS ONE IS BETTER
    app.put("movies"){ req -> EventLoopFuture<HTTPStatus> in
        // 1. Decode the content into movie
         Movie.decodeRequest(req)
            //2. pull the movie out
            .flatMap { newMovie -> EventLoopFuture<HTTPStatus> in
                //3. find the movie in the database
                Movie.find(newMovie.id, on: req.db)
                    //4. unwraps the find optional, aborts if nil
                    .unwrap(or: Abort(.notFound))
                    //5. flatMap is for async operations inside the flatMap (update)
                    .flatMap { (movie) -> EventLoopFuture<HTTPStatus> in
                        movie.title = newMovie.title
                        //6. updates the DB
                        return movie.update(on: req.db)
                            //7. Sends the ok status
                            .transform(to: .ok)
                    }
            }
    }
    
    // /movies/:id DELETE
    app.delete("movies",":movieId") { req -> EventLoopFuture<HTTPStatus> in
        return Movie
            .find(req.parameters.get("movieId"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.delete(on: req.db)
            }.transform(to: .ok)
        
    }
    
    
    //movies POST
    app.post("movies") { req -> EventLoopFuture<Movie> in
        let movie = try req.content.decode(Movie.self)
        return movie.create(on: req.db).map { movie }
    }
    
    app.post("reviews") { req -> EventLoopFuture<Review> in
        
        let review = try req.content.decode(Review.self)
        
        return review
            //1. creates the review in the db
            .create(on: req.db)
            //2. send the review back to the user so they can see?
            .map { review }
        
    }
    
}
