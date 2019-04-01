//
//  ViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Treehouse on 12/8/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
   
    
    
    @IBOutlet weak var GuestButton: UIButton!
    @IBOutlet weak var EmployeeButton: UIButton!
    @IBOutlet weak var VendorButton: UIButton!
    @IBOutlet weak var ManagerButton: UIButton!
    
    
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var Button5: UIButton!
    
    
    @IBOutlet weak var DateOfBirth: UITextField!
    @IBOutlet weak var DateOfVisit: UITextField!
    @IBOutlet weak var Project: UITextField!    
    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var Company: UITextField!
    @IBOutlet weak var Street: UITextField!
    @IBOutlet weak var City: UITextField!
    @IBOutlet weak var State: UITextField!
    @IBOutlet weak var ZipCode: UITextField!
    
    
    var firstRowButton: FirstRowButtonType? = nil
    var secondRowButton: SecondRowButtonType? = nil
    
    var pass: Pass? = nil
    let companyData: [String] = [VendorCompany.Acme.rawValue, VendorCompany.Fedex.rawValue, VendorCompany.NWElectrical.rawValue, VendorCompany.Orkin.rawValue]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideButtons()
        
        // Observer for Keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Adding Done button for all the input fields (Keyboard, UIPicker)
        addDoneButton()
        
        // Setting placeholders for textfields
        insertPlaceHolders()
        
        // Company picker
        let companyPicker = UIPickerView()
        Company.inputView = companyPicker
        companyPicker.delegate = self
        
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // sending pass via segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPass" {
            let vc = segue.destination as! PageViewController
            vc.pass = pass
        }
    }
    
    
    @IBAction func guestActivated(_ sender: UIButton) {
        showButtons()
        Button1.setTitle("Child", for: .normal)
        Button2.setTitle("Adult", for: .normal)
        Button3.setTitle("Senior", for: .normal)
        Button4.setTitle("VIP", for: .normal)
        Button5.setTitle("SeasonPass", for: .normal)
        
        firstRowButton = FirstRowButtonType.Guest
    }
    
    @IBAction func employeeActivated(_ sender: UIButton) {
    
        showButtons()
        Button1.setTitle("Food Service", for: .normal)
        Button2.setTitle("Ride Service", for: .normal)
        Button3.setTitle("Maintenance", for: .normal)
        Button4.setTitle("Contract", for: .normal)
        Button5.isHidden = true
        
        firstRowButton = FirstRowButtonType.Employee
    }
    
    @IBAction func managerActivated(_ sender: UIButton) {
        hideButtons()
        firstRowButton = FirstRowButtonType.Manager
        setActiveTextFields()
    }
    
    @IBAction func vendorActivated(_ sender: UIButton) {
        hideButtons()
        firstRowButton = FirstRowButtonType.Vendor
        setActiveTextFields()
    }
    
    @IBAction func button1Activaterd(_ sender: UIButton) {
        if sender.currentTitle == "Child" {
            secondRowButton = SecondRowButtonType.Child
            setActiveTextFields()
        }
        
        if sender.currentTitle == "Food Service" {
            secondRowButton = SecondRowButtonType.FoodService
            setActiveTextFields()
        }
    }
    
    @IBAction func button2Activated(_ sender: UIButton) {

        if sender.currentTitle == "Adult" {
            secondRowButton = SecondRowButtonType.Adult
            setActiveTextFields()
        }
        
        if sender.currentTitle == "Ride Service" {
            secondRowButton = SecondRowButtonType.RideService
            setActiveTextFields()
        }
    }
    
    @IBAction func button3Activated(_ sender: UIButton) {
   
        if sender.currentTitle == "Senior" {
            secondRowButton = SecondRowButtonType.Senior
            setActiveTextFields()
        }
        
        if sender.currentTitle == "Maintenance" {
            secondRowButton = SecondRowButtonType.Maintenance
            setActiveTextFields()
        }
    }
    
    @IBAction func button4Activated(_ sender: UIButton) {
   
        if sender.currentTitle == "VIP" {
            secondRowButton = SecondRowButtonType.VIP
            setActiveTextFields()
        }
        
        if sender.currentTitle == "Contract" {
            secondRowButton = SecondRowButtonType.Contract
            setActiveTextFields()
        }
    }
    
    
    @IBAction func button5Activated(_ sender: UIButton) {
        if sender.currentTitle == "SeasonPass" {
            secondRowButton = SecondRowButtonType.SeasonPass
            setActiveTextFields()
        }
    }
    
    
    // Date pickers -----------------
    @IBAction func dateOfBirthPicker(_ sender: UITextField) {
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        DateOfBirth.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(ViewController.updateDateOfBirthFromValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func updateDateOfBirthFromValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        DateOfBirth.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func dateOfVisitPicker(_ sender: UITextField) {
   
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        DateOfVisit.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(ViewController.updateDateOfVisitFromValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func updateDateOfVisitFromValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        DateOfVisit.text = dateFormatter.string(from: sender.date)
    }
    //----------------------------
    
    
    // helper functions for company picker ----------
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return companyData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return companyData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Company.text = companyData[row]
    }
    //-------------------------------------------------
    
    @IBAction func generatePass(_ sender: UIButton) {
        guard let firstRowButtonUnwrapped = firstRowButton else {
            print("Empty")
            return
        }
        
        switch firstRowButtonUnwrapped {
        case .Guest:
            // There are 5 options for Guests
            //Child
            if secondRowButton == SecondRowButtonType.Child {
                let dateFromString = createDateFormatter(textField: DateOfBirth)
                do {
                    let child = try FreeChildGuest(dateOfBirth: dateFromString)
                    pass = CheckPoint.generatePass(entrant: child)
                } catch {
                    genericAlert(error: error)
                }
            }
            
            // Adult
            if secondRowButton == SecondRowButtonType.Adult {
                let adult = ClassicGuest()
                pass = CheckPoint.generatePass(entrant: adult)
            }
            
            
            // Senior
            if secondRowButton == SecondRowButtonType.Senior {
                let dateFromString = createDateFormatter(textField: DateOfBirth)
                do {
                    let senior = try SeniorGuest(firstName: FirstName.text, lastName: LastName.text, dateOfBirth: dateFromString)
                    pass = CheckPoint.generatePass(entrant: senior)
                } catch {
                    genericAlert(error: error)
                }
            }
            
            // VIP
            if secondRowButton == SecondRowButtonType.VIP {
                let vip = VIPGuest()
                pass = CheckPoint.generatePass(entrant: vip)
            }
            
            // SeasonPass
            if secondRowButton == SecondRowButtonType.SeasonPass {
                let dateFromString = createDateFormatter(textField: DateOfBirth)
                do {
                    let seasonPassGuest = try SeasonPassGuest(firstName: FirstName.text, lastName: LastName.text, streetAddress: Street.text, city: City.text, state: State.text, zipCode: ZipCode.text, dateOfBirth: dateFromString)
                    
                    pass = CheckPoint.generatePass(entrant: seasonPassGuest)
                } catch {
                    genericAlert(error: error)
                }
            }
            
        case .Employee:
            // There are 4 options for employees
            // FoodServiceEmployee
            if secondRowButton == SecondRowButtonType.FoodService {
                let dateFromString = createDateFormatter(textField: DateOfBirth)
                do {
                    let foodServiceEmployee = try FoodServiceEmployee(firstName: FirstName.text, lastName: LastName.text, streetAddress: Street.text, city: City.text, state: State.text, zipCode: ZipCode.text, dateOfBirth: dateFromString)
                    
                    pass = CheckPoint.generatePass(entrant: foodServiceEmployee)
                } catch {
                    genericAlert(error: error)
                }
            }
            
            // RideServiceEmployee
            if secondRowButton == SecondRowButtonType.RideService {
                let dateFromString = createDateFormatter(textField: DateOfBirth)
                do {
                    let rideServiceEmployee = try RideServiceEmployee(firstName: FirstName.text, lastName: LastName.text, streetAddress: Street.text, city: City.text, state: State.text, zipCode: ZipCode.text, dateOfBirth: dateFromString)
                    
                    pass = CheckPoint.generatePass(entrant: rideServiceEmployee)
                } catch {
                    genericAlert(error: error)
                }
            }
            
            // MaintenanceEmployee
            if secondRowButton == SecondRowButtonType.Maintenance {
                let dateFromString = createDateFormatter(textField: DateOfBirth)
                do {
                    let maintenanceEmployee = try MaintenanceEmployee(firstName: FirstName.text, lastName: LastName.text, streetAddress: Street.text, city: City.text, state: State.text, zipCode: ZipCode.text, dateOfBirth: dateFromString)
                    
                    pass = CheckPoint.generatePass(entrant: maintenanceEmployee)
                } catch {
                    genericAlert(error: error)
                }
            }
            
            // ContractEmployee
            if secondRowButton == SecondRowButtonType.Contract {
                if let projectNumberUnwrapped = Project.text {
                    let dateFromString = createDateFormatter(textField: DateOfBirth)
                    do {
                        let contractEmployee = try ContractEmployee(firstName: FirstName.text, lastName: LastName.text, streetAddress: Street.text, city: City.text, state: State.text, zipCode: ZipCode.text, projectNumber: Int(projectNumberUnwrapped), dateOfBirth: dateFromString)
                        
                        pass = CheckPoint.generatePass(entrant: contractEmployee)
                    } catch {
                        genericAlert(error: error)
                    }
                }
            }
            
        case .Manager:
            let dateFromString = createDateFormatter(textField: DateOfBirth)
            do {
                let manager = try Manager(firstName: FirstName.text, lastName: LastName.text, streetAddress: Street.text, city: City.text, state: State.text, zipCode: ZipCode.text, dateOfBirth: dateFromString)
                
                pass = CheckPoint.generatePass(entrant: manager)
            } catch {
                genericAlert(error: error)
            }
            
        case .Vendor:
            let dateOfBirthFromString = createDateFormatter(textField: DateOfBirth)
            let dateOfVisitFromString = createDateFormatter(textField: DateOfVisit)
            
            if let vendorCompanyUnwrapped = Company.text {
                do {
                    let vendor = try Vendor(firstName: FirstName.text, lastName: LastName.text, vendorCompany: VendorCompany(rawValue: vendorCompanyUnwrapped), dateOfBirth: dateOfBirthFromString, dateOfVisit: dateOfVisitFromString)
                    
                    pass = CheckPoint.generatePass(entrant: vendor)
                } catch {
                    genericAlert(error: error)
                }
            }
            
            // End of Switch
        }
        
        validateAllTextFields()
    }
    
    
    
    @IBAction func populateData(_ sender: UIButton) {
        guard let firstRowButtonUnwrapped = firstRowButton else {
            print("Empty")
            return
        }
        
        switch firstRowButtonUnwrapped {
        case .Guest:
            // There are 5 options for Guests
            //Child
            if secondRowButton == SecondRowButtonType.Child {
                DateOfBirth.text = "01-01-2014"
            }
            
            
            // Adult
            if secondRowButton == SecondRowButtonType.Adult {
                
            }
            
            // Senior
            if secondRowButton == SecondRowButtonType.Senior {
                FirstName.text = "Walter"
                LastName.text = "White"
                DateOfBirth.text = "01-01-1960"
            }
            
            // VIP
            if secondRowButton == SecondRowButtonType.VIP {
                
            }
            
            // SeasonPass
            if secondRowButton == SecondRowButtonType.SeasonPass {
                FirstName.text = "Walter"
                LastName.text = "White"
                Street.text = "ABQ"
                City.text = "ABQ"
                State.text = "New Mexico"
                ZipCode.text = "1234"
            }
            
        case .Employee:
            // There are 4 options for employees
            // FoodServiceEmployee
            if secondRowButton == SecondRowButtonType.FoodService {
                FirstName.text = "Walter"
                LastName.text = "White"
                Street.text = "ABQ"
                City.text = "ABQ"
                State.text = "New Mexico"
                ZipCode.text = "1234"
            }
            
            // RideServiceEmployee
            if secondRowButton == SecondRowButtonType.RideService {
                FirstName.text = "Jessi"
                LastName.text = "Pinkman"
                Street.text = "ABQ"
                City.text = "ABQ"
                State.text = "New Mexico"
                ZipCode.text = "4321"
            }
            
            // MaintenanceEmployee
            if secondRowButton == SecondRowButtonType.Maintenance {
                FirstName.text = "Saul"
                LastName.text = "Goodman"
                Street.text = "ABQ"
                City.text = "ABQ"
                State.text = "New Mexico"
                ZipCode.text = "00000"
            }
            
            // ContractEmployee
            if secondRowButton == SecondRowButtonType.Contract {
                FirstName.text = "Jimmi"
                LastName.text = "Markson"
                Street.text = "ABQ"
                City.text = "ABQ"
                State.text = "New Mexico"
                ZipCode.text = "00000"
                Project.text = "1002"
            }
            
        case .Manager:
            FirstName.text = "Elon"
            LastName.text = "Musk"
            Street.text = "ABQ"
            City.text = "ABQ"
            State.text = "Nevada"
            ZipCode.text = "88888"
            
            
        case .Vendor:
            FirstName.text = "Jack"
            LastName.text = "Ma"
            Company.text = "Fedex"
            DateOfBirth.text = "01-01-1960"
            DateOfVisit.text = "01-01-2015"
        }
        
    }
    
    
    // Helper methods
    // Method to hide the buttons at the second row
    func hideButtons() {
        Button1.isHidden = true
        Button2.isHidden = true
        Button3.isHidden = true
        Button4.isHidden = true
        Button5.isHidden = true
    }
    
    // Method to show the buttons at the second row
    func showButtons() {
        Button1.isHidden = false
        Button2.isHidden = false
        Button3.isHidden = false
        Button4.isHidden = false
        Button5.isHidden = false
        
    }
    
    
    func disableAllTextFields() {
        disableTextField(textField: DateOfBirth)
        disableTextField(textField: DateOfVisit)
        disableTextField(textField: Project)
        disableTextField(textField: FirstName)
        disableTextField(textField: LastName)
        disableTextField(textField: Company)
        disableTextField(textField: Street)
        disableTextField(textField: City)
        disableTextField(textField: State)
        disableTextField(textField: ZipCode)
    }
    
    func enableAllTextField() {
        enableTextField(textField: DateOfBirth)
        enableTextField(textField: DateOfVisit)
        enableTextField(textField: Project)
        enableTextField(textField: FirstName)
        enableTextField(textField: LastName)
        enableTextField(textField: Company)
        enableTextField(textField: Street)
        enableTextField(textField: City)
        enableTextField(textField: State)
        enableTextField(textField: ZipCode)
    }
    
    
    func disableTextField(textField: UITextField){
        textField.isEnabled = false
        textField.backgroundColor = UIColor.lightGray
        textField.text = ""
    }
    
    
    func enableTextField(textField: UITextField) {
        textField.isEnabled = true
        textField.backgroundColor = UIColor.white
        textField.text = ""
    }
    
    
    func validateAllTextFields() {
        validateTextField(textField: FirstName)
        validateTextField(textField: LastName)
        validateTextField(textField: Project)
        validateTextField(textField: Street)
        validateTextField(textField: State)
        validateTextField(textField: City)
        validateTextField(textField: ZipCode)
        
    }
    
    // function to set placeholders for textfields
    func insertPlaceHolders() {
        FirstName.placeholder = "First Name"
        LastName.placeholder = "Last Name"
        Street.placeholder = "Street Address"
        City.placeholder = "City"
        State.placeholder = "State"
        Project.placeholder = "Project"
        ZipCode.placeholder = "Zip Code"
    }
    
    // function to add Done button for all the input fields (Keyboard, UIPicker)
    func addDoneButton() {
        // toolbar
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(ViewController.dismissPicker))
        
        DateOfBirth.inputAccessoryView = toolBar
        DateOfVisit.inputAccessoryView = toolBar
        Project.inputAccessoryView = toolBar
        FirstName.inputAccessoryView = toolBar
        LastName.inputAccessoryView = toolBar
        Company.inputAccessoryView = toolBar
        Street.inputAccessoryView = toolBar
        City.inputAccessoryView = toolBar
        State.inputAccessoryView = toolBar
        ZipCode.inputAccessoryView = toolBar
    }
    
    // function to enable/disable textfields
    func setActiveTextFields() {
        
        guard let firstRowButtonUnwrapped = firstRowButton else {
            print("Not gonna happen!")
            return
        }
        
        switch firstRowButtonUnwrapped {
        case .Guest:
            // Child
            if let secondRowButtonUnwrapped = secondRowButton {
                if secondRowButtonUnwrapped == .Child {
                    disableAllTextFields()
                    enableTextField(textField: DateOfBirth)
                }
            }
            // Adult
            if let secondRowButtonUnwrapped = secondRowButton {
                if secondRowButtonUnwrapped == .Adult {
                    disableAllTextFields()
                }
            }
            // Senior
            if let secondRowButtonUnwrapped = secondRowButton {
                if secondRowButtonUnwrapped == .Senior {
                    disableAllTextFields()
                    enableTextField(textField: DateOfBirth)
                    enableTextField(textField: FirstName)
                    enableTextField(textField: LastName)
                }
            }
            // VIP
            if let secondRowButtonUnwrapped = secondRowButton {
                if secondRowButtonUnwrapped == .VIP {
                    disableAllTextFields()
                }
            }
            // SeasonPass
            if let secondRowButtonUnwrapped = secondRowButton {
                if secondRowButtonUnwrapped == .SeasonPass {
                    enableAllTextField()
                    disableTextField(textField: DateOfVisit)
                    disableTextField(textField: Project)
                    disableTextField(textField: Company)
                }
            }
            
        case .Employee:
            // Food Service
            if let secondRowButtonUnwrapped = secondRowButton {
                if secondRowButtonUnwrapped == .FoodService {
                    enableAllTextField()
                    disableTextField(textField: DateOfVisit)
                    disableTextField(textField: Project)
                    disableTextField(textField: Company)
                }
            }
            // Ride Service
            if let secondRowButtonUnwrapped = secondRowButton {
                if secondRowButtonUnwrapped == .RideService {
                    enableAllTextField()
                    disableTextField(textField: DateOfVisit)
                    disableTextField(textField: Project)
                    disableTextField(textField: Company)
                }
            }
            // Maintenance
            if let secondRowButtonUnwrapped = secondRowButton {
                if secondRowButtonUnwrapped == .Maintenance {
                    enableAllTextField()
                    disableTextField(textField: DateOfVisit)
                    disableTextField(textField: Project)
                    disableTextField(textField: Company)
                }
            }
            // Contract
            if let secondRowButtonUnwrapped = secondRowButton {
                if secondRowButtonUnwrapped == .Contract {
                    enableAllTextField()
                    disableTextField(textField: DateOfVisit)
                    disableTextField(textField: Company)
                }
            }
            
        case.Manager:
            enableAllTextField()
            disableTextField(textField: DateOfVisit)
            disableTextField(textField: Project)
            disableTextField(textField: Company)
            
        case .Vendor:
            enableAllTextField()
            disableTextField(textField: Project)
            disableTextField(textField: Street)
            disableTextField(textField: City)
            disableTextField(textField: State)
            disableTextField(textField: ZipCode)
        }
        
    }
    
    
}



