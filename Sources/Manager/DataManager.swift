import Foundation

public protocol DataManager {
    func load() -> [Ue]
    func loadUeStage_Proj() -> [Ue]
    func save(ues: [Ue])
}
