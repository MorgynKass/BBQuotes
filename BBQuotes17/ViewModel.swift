//
//  ViewModel.swift
//  BBQuotes17
//
//  Created by Morgyn Peay on 6/19/24.
//
import Foundation

@Observable
class ViewModel {
    enum FetchStatus {
        case notStarted
        case fetching
        case successQuote
        case successEpisode
        case failed(error: Error)
    }
    
    private(set) var status: FetchStatus = .notStarted
    
    private let fetcher = FetchDataController()
    
    var quote: Quote
    var character: Character
    var episode: Episode
    
    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let quoteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        
        let characterData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        
        let episodeData = try! Data(contentsOf: Bundle.main.url(forResource: "sampleepisode", withExtension: "json")!)
        
        quote = try! decoder.decode(Quote.self, from: quoteData)
        character = try! decoder.decode(Character.self, from: characterData)
        episode = try! decoder.decode(Episode.self, from: episodeData)
    }
    
    func getQuoteData(for show: String) async {
        status = .fetching
        
        do {
            quote = try await fetcher.fetchQuote(from: show)
            
            character = try await fetcher.fetchCharacter(quote.character)
            
            character.death = try await fetcher.fetchDeath(for: character.name)
            
            status = .successQuote
        } catch {
            status = .failed(error: error)
        }
    }
    
    func getEpisodeData(for show: String) async {
        status = .fetching
        
        do {
            if let unwrappedEpisode = try await fetcher.fetchEpisode(from: show) {
                episode = unwrappedEpisode
                
                status = .successEpisode
            }
            
        } catch {
            status = .failed(error: error)
        }
    }
}
