//
//  Character.swift
//  CloudKit
//
//  Created by Richard Blanchard on 2/21/19.
//  Copyright © 2019 Richard Blanchard. All rights reserved.
//

import Foundation
import CloudKit

protocol CKRecordInstantiable {
    static func create(from record: CKRecord) -> Self
}

protocol CKRecordCreatable {
    var record: CKRecord { get }
    var uniquePredicate: NSPredicate { get }
}

protocol CKRecordable: CKRecordInstantiable, CKRecordCreatable {
    static var recordType: CKRecord.RecordType { get }
}

extension CKRecordInstantiable where Self: Decodable {
    // TODO - Let's use some coding key magic here if possible
}

struct Character: Decodable {
    let url: String
    let name: String
    let gender: String
    let culture: String
    let born: String
    let died: String
    let titles: [String]
    let aliases: [String]
    let father: String
    let mother: String
    let spouse: String
    let allegiances: [String]
    let books: [String]
    let povBooks: [String]
    let tvSeries: [String]
    let playedBy: [String]
}



extension Character: CKRecordable {
    var uniquePredicate: NSPredicate {
        return NSPredicate(format: "url = %@", url)
    }

    static var recordType: CKRecord.RecordType {
        return "Character"
    }

    var record: CKRecord {
        let recordID = CKRecord.ID(recordName: UUID().uuidString)
        let record = CKRecord(recordType: Character.recordType, recordID: recordID)

        record[CodingKeys.url.stringValue] = url
        record[CodingKeys.name.stringValue] = name
        record[CodingKeys.gender.stringValue] = gender
        record[CodingKeys.culture.stringValue] = culture
        record[CodingKeys.born.stringValue] = born
        record[CodingKeys.died.stringValue] = died
        record[CodingKeys.titles.stringValue] = titles
        record[CodingKeys.aliases.stringValue] = aliases
        record[CodingKeys.father.stringValue] = father
        record[CodingKeys.mother.stringValue] = mother
        record[CodingKeys.spouse.stringValue] = spouse
        record[CodingKeys.allegiances.stringValue] = allegiances
        record[CodingKeys.books.stringValue] = books
        record[CodingKeys.povBooks.stringValue] = povBooks
        record[CodingKeys.tvSeries.stringValue] = tvSeries
        record[CodingKeys.playedBy.stringValue] = playedBy

        return record
    }

    static func create(from record: CKRecord) -> Character {
        let url = record[CodingKeys.url.stringValue] as! String
        let name = record[CodingKeys.name.stringValue] as! String
        let gender = record[CodingKeys.gender.stringValue] as! String
        let culture = record[CodingKeys.culture.stringValue] as! String
        let born = record[CodingKeys.born.stringValue] as! String
        let died = record[CodingKeys.died.stringValue] as! String
        let titles = record[CodingKeys.titles.stringValue] as! [String]
        let aliases = record[CodingKeys.aliases.stringValue] as! [String]
        let father = record[CodingKeys.father.stringValue] as! String
        let mother = record[CodingKeys.mother.stringValue] as! String
        let spouse = record[CodingKeys.spouse.stringValue] as! String
        let allegiances = record[CodingKeys.allegiances.stringValue] as! [String]
        let books = record[CodingKeys.books.stringValue] as! [String]
        let povBooks = record[CodingKeys.povBooks.stringValue] as! [String]
        let tvSeries = record[CodingKeys.tvSeries.stringValue] as! [String]
        let playedBy = record[CodingKeys.playedBy.stringValue] as! [String]

        return Character(url: url, name: name, gender: gender, culture: culture, born: born, died: died, titles: titles, aliases: aliases, father: father, mother: mother, spouse: spouse, allegiances: allegiances, books: books, povBooks: povBooks, tvSeries: tvSeries, playedBy: playedBy)
    }
}

extension Character: CustomStringConvertible {
    var description: String {
        return
        """
        url: \(url)
        name: \(name)
        gender: \(gender)
        born: \(born)
        died: \(died)
        titles: \(titles)
        aliases: \(aliases)
        father: \(father)
        mother: \(mother)
        spouse: \(spouse)
        allegiances: \(allegiances)
        books: \(books)
        povBooks: \(povBooks)
        tvSeries: \(tvSeries)
        playedBy: \(playedBy)
        """
    }
}




/*
{
    "url":"https://anapioficeandfire.com/api/characters/583",
    "name":"Jon Snow",
    "gender":"Male",
    "culture":"Northmen",
    "born":"In 283 AC",
    "died":"",
    "titles":[
    "Lord Commander of the Night's Watch"
    ],
    "aliases":[
    "Lord Snow",
    "Ned Stark's Bastard",
    "The Snow of Winterfell",
    "The Crow-Come-Over",
    "The 998th Lord Commander of the Night's Watch",
    "The Bastard of Winterfell",
    "The Black Bastard of the Wall",
    "Lord Crow"
    ],
    "father":"",
    "mother":"",
    "spouse":"",
    "allegiances":[
    "https://anapioficeandfire.com/api/houses/362"
    ],
    "books":[
    "https://anapioficeandfire.com/api/books/5"
    ],
    "povBooks":[
    "https://anapioficeandfire.com/api/books/1",
    "https://anapioficeandfire.com/api/books/2",
    "https://anapioficeandfire.com/api/books/3",
    "https://anapioficeandfire.com/api/books/8"
    ],
    "tvSeries":[
    "Season 1",
    "Season 2",
    "Season 3",
    "Season 4",
    "Season 5",
    "Season 6"
    ],
    "playedBy":[
    "Kit Harington"
    ]
}
 */
