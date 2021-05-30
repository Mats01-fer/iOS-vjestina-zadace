//
// Created by Matej Butkovic on 29.05.2021..
//

import Foundation
import Reachability
import CoreData

class QuizRepository {
    
    private let databaseDataSource: QuizDatabaseDataSource
    private let networkDataSource: QuizNetworkDataSource
    private let coreDataContext: NSManagedObjectContext
    
    
    init(databaseDataSource: QuizDatabaseDataSource, networkDataSource: QuizNetworkDataSource) {
        self.databaseDataSource = databaseDataSource
        self.networkDataSource = networkDataSource
        self.coreDataContext = CoreDataStack(modelName: "Model").managedContext
    }
    
    func fetchQuizzesFromRemote(completionHandler: @escaping (Result<[Quiz], RequestError>) -> Void) {
        networkDataSource.fetchQuizzes { [weak self] (result: Result<QuizzesResponse, RequestError>) in
            guard let self = self else {
                return
            }
            switch result {
            case .failure(_):
                completionHandler(.success(self.getLocalQuizzes()))
                
            case .success(let value):
                // update local storage with value then do stuff
                value.quizzes.forEach { quiz in
                    do {
                        let cdQuiz = try self.getQuiz(withId: quiz.id) ?? CDQuiz(context: self.coreDataContext)
                        quiz.populate(cdQuiz, in: self.coreDataContext)
                        
                        quiz.questions.forEach { question in
                            do {
                                let cdQuestion = try self.getQuestion(withId: question.id) ?? CDQuesiton(context: self.coreDataContext)
                                question.populate(cdQuestion, in: self.coreDataContext)
                                cdQuiz.addToQuestions(cdQuestion)
                            } catch {
                                print("Error when fetching/creating a quiz: \(error)")
                            }
                        }
                    } catch {
                        print("Error when saving updated quiz: \(error)")
                    }
                }
                do {
                    try self.coreDataContext.save()
                } catch {
                    print("Error when saving updated quiz: \(error)")
                }
                completionHandler(.success(self.getLocalQuizzes()))
            }
            
        }
    }
    
    func getLocalQuizzes() -> [Quiz] {
        print("I am getting you some quizzes from local storage")
        //        return [Quiz(id: 1, title: "Test", description: "static test", category: .sport, level: 2, imageUrl: "", questions: [Question(id: 1, question: "a question", answers: ["a", "b", "c", "d"], correctAnswer: 0)])]
        //
        let request: NSFetchRequest<CDQuiz> = CDQuiz.fetchRequest()
        
        do {
            return try coreDataContext.fetch(request).map { Quiz(with: $0) }
        } catch {
            print("Error when fetching restaurants from core data: \(error)")
            return []
        }
    }
    
    private func getQuestion(withId id: Int) throws -> CDQuesiton? {
        let request: NSFetchRequest<CDQuesiton> = CDQuesiton.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %u", #keyPath(CDQuesiton.identifier), id)
        
        let cdResponse = try coreDataContext.fetch(request)
        return cdResponse.first
    }
    
    private func getQuiz(withId id: Int) throws -> CDQuiz? {
        let request: NSFetchRequest<CDQuiz> = CDQuiz.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %u", #keyPath(CDQuiz.identifier), id)
        
        let cdResponse = try coreDataContext.fetch(request)
        return cdResponse.first
    }
    
    
}
