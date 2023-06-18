//
//  CRUDPriceRule.swift
//  InDoor-Admin
//
//  Created by Ahmed on 18/06/2023.
//

import UIKit

extension PriceRuleViewController {
    
    func prepareEditingPanel(){
        startDatePicler.minimumDate = Date()
        endDatePicker.minimumDate = Date()
        editingPanelView.giveShadowAndRadius(shadowRadius: 7, cornerRadius: 20)
    }
    
    @IBAction func DoneEditing(_ sender: Any) {
        if checkFieldsAreNotEmpty() {
            if checkDatesAreInTheRightOrder(){
                if usageLimitIsInt(){
                    if segmentedControlMatchesAmount(){
                        setRuleData()
                        saveRuleToCloud()
                        animateDone()
                    }
                }
            }
        }
    }
    
    func checkFieldsAreNotEmpty() -> Bool {
        if titleTextFileld.text == "" || disountAmountTextField.text == "" || usageLimitTextField.text == "" || minimumSubtotalTextField.text == ""{
            InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.emptyFields)
            return false
        }else{
            return true
        }
    }
    
    func checkDatesAreInTheRightOrder() -> Bool {
        if startDatePicler.date >= endDatePicker.date {
            InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.wrongDateOrder)
            return false
        }else{
            return true
        }
    }
    
    func usageLimitIsInt() -> Bool {
        if Int(usageLimitTextField.text!) != nil {
            return true
        }else{
            InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.wrongUsageLimitNumber)
            return false
        }
    }
    
    func segmentedControlMatchesAmount() -> Bool {
        if Double(disountAmountTextField.text!) == nil {
            InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.wrongAmountNumber)
            return false
        }
        
        if Double(minimumSubtotalTextField.text!) == nil {
            InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.wrongMinimumSubtotalNumber)
            return false
        }
        if typeSegmentedControl.selectedSegmentIndex == 0{
            if Int(disountAmountTextField.text!)! > 100 {
                InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.wrongPercentage)
                return false
            }else{
                return true
            }
        }else{
            if Double(disountAmountTextField.text!)! > Double(minimumSubtotalTextField.text!)! {
                InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.wrongDiscountToSubtotal)
                return false
            }else{
                return true
            }
        }
    }
    
    func setRuleData(){
        ruleBeingHandled.title = titleTextFileld.text
        ruleBeingHandled.usageLimit = Int(usageLimitTextField.text!)
        if Double(disountAmountTextField.text!)! <= 0 {
            ruleBeingHandled.value = disountAmountTextField.text
        }else{
            ruleBeingHandled.value = String(Double(disountAmountTextField.text!)! * -1)
        }
        ruleBeingHandled.startsAt = startDatePicler.date.iso8601
        ruleBeingHandled.endsAt = endDatePicker.date.iso8601
        ruleBeingHandled.prerequisiteSubtotalRange?.greaterThanOrEqualTo = minimumSubtotalTextField.text
        if typeSegmentedControl.selectedSegmentIndex == 0{
            ruleBeingHandled.valueType = "percentage"
        }else{
            ruleBeingHandled.valueType = "fixed_amount"
        }
    }
    
    func saveRuleToCloud(){
        if editOrAdd == "add" {
            priceRuleViewModel.addPriceRule(priceRule: ruleBeingHandled) { [weak self] rule in
                self?.rulesList.append(rule)
                self?.priceRulesTable.reloadData()
                self?.networkIndicator.stopAnimating()
            }
        }else{
            priceRuleViewModel.updatePriceRule(priceRule: ruleBeingHandled) { [weak self] rule in
                self?.rulesList[(self?.selectedRuleIndex)!] = rule
                self?.priceRulesTable.reloadData()
                self?.networkIndicator.stopAnimating()
            }
        }
    }
    
    func animateDone(){
        doneAnimation.isHidden = false
        doneAnimation.contentMode = .scaleAspectFit
        doneAnimation.loopMode = .playOnce
        doneAnimation.play { [weak self] done in
            self?.doneAnimation.isHidden = true
            self?.hideEditingPanel()
            self?.resetViews()
        }
    }
    
    func resetViews(){
        titleTextFileld.text = ""
        startDatePicler.date = Date()
        endDatePicker.date = Date()
        typeSegmentedControl.selectedSegmentIndex = 0
        disountAmountTextField.text = ""
        usageLimitTextField.text = ""
        minimumSubtotalTextField.text = ""
    }
    
    @IBAction func exitEditPanel(_ sender: Any) {
        hideEditingPanel()
        resetViews()
    }
}
