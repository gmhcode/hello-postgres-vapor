import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    let moviesController = MoviesController()
    let reviewsController = ReviewsController()
    
    
//    http://localhost:8080/movies POST
    app.post("movies", use: moviesController.create)
    
//    http://localhost:8080/movies GET
    app.get("movies", use: moviesController.all)
    
    //    http://localhost:8080/movies/:movieId DELETE
    app.delete("movies",":movieId", use: moviesController.delete)
    
    //    http://localhost:8080/movies/ POST
    app.post("reviews", use: reviewsController.create)
    
    //    http://localhost:8080/movies/:movieId/reviews GET
    app.get("movies",":movieId","reviews", use: reviewsController.getByMovieId)
}


//func routes(_ app: Application) throws {
//
//    let moviesController = MoviesController()
//
//    app.post("movies", use: moviesController.create)
//
//    app.get("movies", use: moviesController.all)
//
//
//    //movie/:movieId/actor/:actorId
//    app.post("movie",":movieId","actor",":actorId") { req -> EventLoopFuture<HTTPStatus> in
//
//        //get the movie
//        let movie = Movie
//            .find(req.parameters.get("movieId"), on: req.db)
//            .unwrap(or: Abort(.notFound))
//
//        //get actor
//        let actor = Actor
//            .find(req.parameters.get("actorId"), on: req.db)
//            .unwrap(or: Abort(.notFound))
//
//        return movie
//            .and(actor)
//            .flatMap { (movie, actor) in
//
//            movie.$actors.attach(actor, on: req.db)
//
//        }.transform(to: .ok)
//    }
//
//
//
//    //gives us actors with their movies
//    app.get("actors"){ req in
//        Actor
//            //1 about to query the db for all Actor types
//            .query(on: req.db)
//            //2. with their corresponding movies
//            .with(\.$movies)
//            //3. returns them all
//            .all()
//    }
//
//
//
//    app.post("actors") { req -> EventLoopFuture<Actor> in
//
//        let actor = try req.content.decode(Actor.self)
//        return actor.create(on: req.db).map { actor }
//    }
//
//
//
//    //Get
//    app.get("movies") { req in
//        Movie
//            .query(on: req.db)
//            //1. serves all the reviews with this movie
//            .with(\.$reviews)
//            //2. and all the actors
//            .with(\.$actors)
//            .all()
//    }
//
//    // /movies/id
//    app.get("movies",":movieId") { req -> EventLoopFuture<Movie> in
//        Movie
//            .find(req.parameters.get("movieId"), on: req.db)
//            .unwrap(or: Abort(.notFound))
//    }
//
//    // /movies PUT - body needs to have the correct id with the updated movie
//    app.put("movies"){ req -> EventLoopFuture<HTTPStatus> in
//        // 1. Decode the content into movie
//        let movie = try req.content.decode(Movie.self)
//
//        return Movie
//            //2. find the movie in the database
//            .find(movie.id, on: req.db)
//            //3. unwraps the find optional, aborts if nil
//            .unwrap(or: Abort(.notFound))
//            //4. flatMap is for async operations inside the flatMap (update)
//            .flatMap {
//                $0.title = movie.title
//                //5. updates the DB
//                return $0.update(on: req.db)
//                //6. Sends the ok status
//                    .transform(to: .ok)
//            }
//    }
//
//    //Fully ASYNC update THIS ONE IS BETTER
//    app.put("movies"){ req -> EventLoopFuture<HTTPStatus> in
//        // 1. Decode the content into movie
//         Movie.decodeRequest(req)
//            //2. pull the movie out
//            .flatMap { newMovie -> EventLoopFuture<HTTPStatus> in
//                //3. find the movie in the database
//                Movie.find(newMovie.id, on: req.db)
//                    //4. unwraps the find optional, aborts if nil
//                    .unwrap(or: Abort(.notFound))
//                    //5. flatMap is for async operations inside the flatMap (update)
//                    .flatMap { (movie) -> EventLoopFuture<HTTPStatus> in
//                        movie.title = newMovie.title
//                        //6. updates the DB
//                        return movie.update(on: req.db)
//                            //7. Sends the ok status
//                            .transform(to: .ok)
//                    }
//            }
//    }
//
//    // /movies/:id DELETE
//    app.delete("movies",":movieId") { req -> EventLoopFuture<HTTPStatus> in
//        return Movie
//            .find(req.parameters.get("movieId"), on: req.db)
//            .unwrap(or: Abort(.notFound))
//            .flatMap {
//                $0.delete(on: req.db)
//            }.transform(to: .ok)
//
//    }
//
//
//    //movies POST
////    app.post("movies") { req -> EventLoopFuture<Movie> in
////        let movie = try req.content.decode(Movie.self)
////        return movie.create(on: req.db).map { movie }
////    }
//
//    app.post("reviews") { req -> EventLoopFuture<Review> in
//
//        let review = try req.content.decode(Review.self)
//
//        return review
//            //1. creates the review in the db
//            .create(on: req.db)
//            //2. send the review back to the user so they can see?
//            .map { review }
//
//    }
//
//}
