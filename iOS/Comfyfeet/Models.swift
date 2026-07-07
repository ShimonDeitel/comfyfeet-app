import Foundation

struct NightLog: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var createdAt: Date = Date()
    var feetWereCold: Bool
    var woreSocks: Bool

    init(id: UUID = UUID(), createdAt: Date = Date(), feetWereCold: Bool = true, woreSocks: Bool = false) {
        self.id = id
        self.createdAt = createdAt
        self.feetWereCold = feetWereCold
        self.woreSocks = woreSocks
    }
}
