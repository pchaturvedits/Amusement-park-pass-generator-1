//
//  PageViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Manish Chaturvedi on 3/10/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import UIKit
import AudioToolbox


class PageViewController: UIViewController{
 
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var passTypeLabel: UILabel!
    @IBOutlet weak var rideAccessLabel: UILabel!
    @IBOutlet weak var foodDiscountLabel: UILabel!
    @IBOutlet weak var merchandiseDiscountLabel: UILabel!
    @IBOutlet weak var testResultLabel: UILabel!
    
    var pass: Pass?
    
    // Audio variables
    var accessDenied: SystemSoundID = 0
    var accessGranted: SystemSoundID = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSounds()
        
        if let firstNameUnwarpped = pass?.firstName, let lastNameUnwarpped = pass?.lastName {
            nameLabel.text = "\(firstNameUnwarpped) \(lastNameUnwarpped)"
        }
        
        if let passTypeUnwrapped = pass?.entrantType {
            passTypeLabel.text = "\(passTypeUnwrapped)"
        }
        
        
        if let ridesAccessUnwrapped = pass?.rideAccess {
            var phrase: String = ""
            for ride in ridesAccessUnwrapped {
                phrase += " \(ride.rawValue)"
            }
            rideAccessLabel.text = phrase
        }
        
        if let discountOnFoodUnwrapped = pass?.discountOnFood {
            foodDiscountLabel.text = "\(discountOnFoodUnwrapped)% Food Discount"
        }
        
        if let discountOnMerchandiseUnwrapped = pass?.discountOnMerchandise {
            merchandiseDiscountLabel.text = "\(discountOnMerchandiseUnwrapped)% Merch Discount"
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

    @IBAction func createNewPass(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
}
    
    @IBAction func testAmusementArea(_ sender: UIButton) {
        // Force unwrapping the pass is OK, as we are 100% sure pass is not nil
        // since user will only see this page if pass is initialized
        if pass!.areaAccess.contains(.amusementAreas) {
      testResultLabel.backgroundColor = .green
            playCorrectAnswerSound()
        } else {
          testResultLabel.backgroundColor = .red
            playWrongAnswerSound()
        }
        testResultLabel.text = CheckPoint.checkPassForAreaAccess(pass: &pass!, to: .amusementAreas)
    }
    
    
    @IBAction func testKitchenArea(_ sender: UIButton) {
        // Force unwrapping the pass is OK, as we are 100% sure pass is not nil
        // since user will only see this page if pass is initialized
        if pass!.areaAccess.contains(.kitchenArea) {
            testResultLabel.backgroundColor = .green
            playCorrectAnswerSound()
        } else {
            testResultLabel.backgroundColor = .red
            playWrongAnswerSound()
        }
        testResultLabel.text = CheckPoint.checkPassForAreaAccess(pass: &pass!, to: .kitchenArea)
    }
    
    
    @IBAction func testOfficeArea(_ sender: UIButton) {
        // Force unwrapping the pass is OK, as we are 100% sure pass is not nil
        // since user will only see this page if pass is initialized
        if pass!.areaAccess.contains(.officeAreas) {
            testResultLabel.backgroundColor = .green
            playCorrectAnswerSound()
        } else {
            testResultLabel.backgroundColor = .red
            playWrongAnswerSound()
        }
        testResultLabel.text = CheckPoint.checkPassForAreaAccess(pass: &pass!, to: .officeAreas)
    }
    
    
    @IBAction func testMaintenanceArea(_ sender: UIButton) {
        // Force unwrapping the pass is OK, as we are 100% sure pass is not nil
        // since user will only see this page if pass is initialized
        if pass!.areaAccess.contains(.maintenanceAreas) {
            testResultLabel.backgroundColor = .green
            playCorrectAnswerSound()
        } else {
        testResultLabel.backgroundColor = .red
            playWrongAnswerSound()
        }
      testResultLabel.text = CheckPoint.checkPassForAreaAccess(pass: &pass!, to: .maintenanceAreas)
    }
    
    
    @IBAction func testRideControlArea(_ sender: UIButton) {
        // Force unwrapping the pass is OK, as we are 100% sure pass is not nil
        // since user will only see this page if pass is initialized
        if pass!.areaAccess.contains(.rideControlAreas) {
            testResultLabel.backgroundColor = .green
            playCorrectAnswerSound()
        } else {
            testResultLabel.backgroundColor = .red
            playWrongAnswerSound()
        }
        testResultLabel.text = CheckPoint.checkPassForAreaAccess(pass: &pass!, to: .rideControlAreas)
    }
    
    
    @IBAction func testRideAccess(_ sender: UIButton) {
        testResultLabel.backgroundColor = .white
        if let ridesAccessUnwrapped = pass?.rideAccess {
            var phrase: String = ""
            for ride in ridesAccessUnwrapped {
                phrase += "\(ride.rawValue)\n"
            }
            testResultLabel.text = phrase
            
            if ridesAccessUnwrapped.count == 0 {
                testResultLabel.text = "No Ride Access!"
                playWrongAnswerSound()
            } else {
                playCorrectAnswerSound()
            }
        }
    }
    
    
    @IBAction func testDiscountAccess(_ sender: UIButton) {
        testResultLabel.backgroundColor = .white
        if let discountOnFoodUnwrapped = pass?.discountOnFood, let discountOnMerchandiseUnwrapped = pass?.discountOnMerchandise {
            testResultLabel.text = "\n\(discountOnFoodUnwrapped)% Food Discount\n\(discountOnMerchandiseUnwrapped)% Merch Discount"
            playCorrectAnswerSound()
        } else {
            testResultLabel.text = "No Discount!"
            playWrongAnswerSound()
        }
    }
    
    
    
    // Helper functions
    // load and play sounds for correct and wrong answer
    func loadSounds() {
        let pathToCorrectSoundFile = Bundle.main.path(forResource: "AccessGranted", ofType: "wav")
        let correctSoundURL = URL(fileURLWithPath: pathToCorrectSoundFile!)
        AudioServicesCreateSystemSoundID(correctSoundURL as CFURL, &accessGranted)
        
        let pathToWrongSoundFile = Bundle.main.path(forResource: "AccessDenied", ofType: "wav")
        let wrongSoundURL = URL(fileURLWithPath: pathToWrongSoundFile!)
        AudioServicesCreateSystemSoundID(wrongSoundURL as CFURL, &accessDenied)
    }
    
    func playCorrectAnswerSound() {
        AudioServicesPlaySystemSound(accessGranted)
    }
    
    func playWrongAnswerSound() {
        AudioServicesPlaySystemSound(accessDenied)
    }
    
    
}































