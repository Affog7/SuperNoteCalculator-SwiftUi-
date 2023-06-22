//
//  FileSCVManager.swift
//  Note
//
//  Created by etudiant on 20/06/2023.
//

import Foundation

class BlocManager  {
    private var blocs: [Bloc] = []
    var stringPath =   "/Users/auaffognon/Downloads/Archive/Sources/blocs.csv"
    func addBloc(_ bloc: Bloc) {
        blocs.append(bloc)
    }
    
    func removeBloc(_ bloc: Bloc) {
        if let index = blocs.firstIndex(of: bloc) {
            blocs.remove(at: index)
        }
    }
    
    func getAllBlocs() -> [Bloc] {
        return blocs
    }
    func updateBlock(bloc : Bloc) {
       
        do {
            try self.loadFromCSVFile()
            self.blocs.removeAll(where: { $0.id == bloc.id })
            self.blocs.append(bloc)
            try  self.updateToCSVFile()
        } catch {
            print("Error saving blocs to CSV file: \(error)")

        }
    }
    
    func updateToCSVFile() throws {
        let fileURL = URL(fileURLWithPath: self.stringPath)
          var csvString = "\n"
        for blc in self.blocs {
            csvString.append(blc.description)
            csvString.append("\n")
        }
            
           
            
            try csvString.write(to: fileURL,atomically: true, encoding: .utf8)
       
    }
    
    func saveToCSVFile(at filePath: String, bloc : Bloc, force: Bool = false) throws {
        let fileURL = URL(fileURLWithPath: filePath)
          var csvString = try String(contentsOf: fileURL)
            
            // var lines = csvString.components(separatedBy: "\n")
            csvString.append("\n")
            csvString.append(bloc.description)
            
            try csvString.write(to: fileURL,atomically: true, encoding: .utf8)
       
    }
    
    
    
    
    func loadFromCSVFile() throws {
        let fileURL = URL(fileURLWithPath: self.stringPath)
        let csvString = try String(contentsOf: fileURL)
        
        let lines = csvString.components(separatedBy: "\n")
        for line in lines {
            let componentss = line.components(separatedBy: ";;;")
            if componentss.count >= 2 {
                let components = componentss[0].components(separatedBy: ",")
                let nom = components[0]
                let isUnique = (components[1] == "true")
                let id = UUID(uuidString: components[2]) ?? UUID()
                let ueString = componentss[1]
                
                // Parse the 'ueString' into an array of 'Ue' objects
                let ues = parseUes(from: ueString)
                
                let bloc = Bloc(nom: nom, ues: ues, isUq: isUnique)
                bloc.id = id
                
                blocs.append(bloc)
            }
        }
    }
    
    private func parseUes(from ueString: String) -> [Ue] {
        let ueComponents = ueString.components(separatedBy: ";;")
        var ues: [Ue] = []
        
        for ueComponent in ueComponents {
            let ueSubcomponentss = ueComponent.components(separatedBy: ",,")
            let ueSubcomponents = ueSubcomponentss[0].components(separatedBy: ",")
            if ueSubcomponents.count >= 3 {
                let ueNom = ueSubcomponents[0]
                let ueCoef = Int(ueSubcomponents[1]) ?? 0
                let ueId = UUID(uuidString: ueSubcomponents[2]) ?? UUID()
                let matieresString = ueSubcomponentss[1]
                
                // Parse the 'matieresString' into an array of 'Matiere' objects
                let matieres = parseMatieres(from: matieresString)
                
                let ue = Ue(id:ueId,nom: ueNom, matieres: matieres, coef: ueCoef)
                
                
                ues.append(ue)
            }
        }
        
        return ues
    }
    
    private func parseMatieres(from matieresString: String) -> [Matiere] {
        let matiereComponents = matieresString.components(separatedBy: ";")
        var matieres: [Matiere] = []
        
        for matiereComponent in matiereComponents {
            let matiereSubcomponents = matiereComponent.components(separatedBy: ",")
            if matiereSubcomponents.count >= 4 {
                let matiereNom = matiereSubcomponents[0]
                let matiereMoyenne = Float(matiereSubcomponents[1]) ?? 0.0
                let matiereCoef = Int(matiereSubcomponents[2]) ?? 0
                let matiereId = UUID(uuidString: matiereSubcomponents[3]) ?? UUID()
                
                let matiere = Matiere(id : matiereId, name: matiereNom, moy: matiereMoyenne, coef: matiereCoef)
              
                
                matieres.append(matiere)
            }
        }
        
        return matieres
    }
}
