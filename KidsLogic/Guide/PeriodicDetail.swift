//
//  PeriodicDetail.swift
//  AbilityToHelp
//
//  Created by Anish on 1/28/24.
//

import UIKit

class PeriodicDetail: UIViewController {

    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var atomicMass: UILabel!
    @IBOutlet weak var atomicNumber: UILabel!
    @IBOutlet weak var atomicRadius: UILabel!
    @IBOutlet weak var block: UILabel!
    @IBOutlet weak var bondingType: UILabel!
    @IBOutlet weak var crystalStructure: UILabel!
    @IBOutlet weak var density: UILabel!
    @IBOutlet weak var electronAffinity: UILabel!
    @IBOutlet weak var electronegativity: UILabel!
    @IBOutlet weak var electronicConfiguration: UILabel!
    @IBOutlet weak var group: UILabel!
    @IBOutlet weak var groupBlock: UILabel!
    @IBOutlet weak var ionRadius: UILabel!
    @IBOutlet weak var ionizationEnergy: UILabel!
    @IBOutlet weak var isotopes: UILabel!
    @IBOutlet weak var magneticOrdering: UILabel!
    @IBOutlet weak var meltingPoint: UILabel!
    @IBOutlet weak var molarHeatCapacity: UILabel!
    @IBOutlet weak var oxidationStates: UILabel!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var speedOfSound: UILabel!
    @IBOutlet weak var standardState: UILabel!
    @IBOutlet weak var vanDelWaalsRadius: UILabel!
    @IBOutlet weak var yearDiscovered: UILabel!
    @IBOutlet weak var minerals: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var myPreodicTable :Preodic? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let periodic = self.myPreodicTable {
            self.name.text =  "\(periodic.name ?? "") \(periodic.symbol ?? "")"
            self.atomicMass.text =  "\("Atomic mass :") \(periodic.atomicMass ?? "")"
            self.atomicNumber.text =  "\("Atomic number :") \(periodic.atomicNumber ?? "")"
            self.atomicRadius.text =  "\("Atomic radius :") \(periodic.atomicRadius ?? "")"
            self.block.text =  "\("Block :") \(periodic.block ?? "")"
            self.bondingType.text =  "\("Bonding type :") \(periodic.bondingType ?? "")"
            self.crystalStructure.text =  "\("Crystal Structure :") \(periodic.crystalStructure ?? "")"
            self.density.text =  "\("Density :") \(periodic.density ?? "")"
            self.electronAffinity.text =  "\("Electron Affinity :") \(periodic.electronAffinity ?? "")"
            self.electronegativity.text =  "\("Electro negativity :") \(periodic.electronegativity ?? "")"
            self.electronicConfiguration.text =  "\("Electronic Configurtion :") \(periodic.electronicConfiguration ?? "")"
            self.group.text =  "\("Group :") \(periodic.group ?? "")"
            self.groupBlock.text =  "\("Group block :") \(periodic.groupBlock ?? "")"
            self.ionRadius.text =  "\("Ion radius :") \(periodic.ionRadius ?? "")"
            self.ionizationEnergy.text =  "\("Ionization energy") \(periodic.ionizationEnergy ?? "")"
            self.isotopes.text =  "\("isotopes :") \(periodic.isotopes ?? "")"
            self.magneticOrdering.text =  "\("Magnetic ordering :") \(periodic.magneticOrdering ?? "")"
            self.meltingPoint.text =  "\("Melting points :") \(periodic.meltingPoint ?? "")"
            self.molarHeatCapacity.text =  "\("Molar heat capacity :") \(periodic.molarHeatCapacity ?? "")"
            self.oxidationStates.text =  "\("Oxidation states :") \(periodic.oxidationStates ?? "")"
            self.period.text =  "\("Period :") \(periodic.period ?? "")"
            self.speedOfSound.text =  "\("Speed of sound :") \(periodic.speedOfSound ?? "")"
            self.standardState.text =  "\("Standard State :") \(periodic.standardState ?? "")"
            self.vanDelWaalsRadius.text =  "\("Van Der Waals Radius :") \(periodic.vanDelWaalsRadius ?? "")"
            self.yearDiscovered.text =  "\("Year of discovers :") \(periodic.yearDiscovered ?? "")"
            self.minerals.text =  "\("Minerals :") \(periodic.minerals ?? "")"
            self.history.text =  "\("History :") \(periodic.history ?? "")"
            
        }
        // Do any additional setup after loading the view.
    }
    

}
