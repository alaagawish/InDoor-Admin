//
//  PriceRuleTableManagment.swift
//  InDoor-Admin
//
//  Created by Ahmed on 18/06/2023.
//

import UIKit

extension PriceRuleViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rulesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PriceRuleConstants.cellName) as! PriceRuleTableViewCell
        cell.setUpPriceRuleData(rule: rulesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 245
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            let alert = UIAlertController(title: Constants.warning, message: Constants.confirmDeleteRule, preferredStyle: .alert)
            let actionDelete = UIAlertAction(title: Constants.delete, style: .destructive) { _ in
                self.priceRuleViewModel.deletePriceRule(priceRule: self.rulesList[indexPath.row])
                self.rulesList.remove(at: indexPath.row)
                self.priceRulesTable.reloadData()
            }
            let actionCancel = UIAlertAction(title: Constants.cancel, style: .cancel)
            alert.addAction(actionDelete)
            alert.addAction(actionCancel)
            self.present(alert, animated: true)
        }
        delete.image = UIImage(systemName: "trash")
        
        let edit = UIContextualAction(style: .normal, title: "Edit") {  (contextualAction, view, boolValue) in
            self.prepareForEdit(index: indexPath.row)
        }
        edit.image = UIImage(systemName: Constants.pencilEditImage)
        edit.backgroundColor = .darkGray
            let swipeActions = UISwipeActionsConfiguration(actions: [delete, edit])
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func prepareForEdit(index: Int){
        editOrAdd = "edit"
        showEditingPanel()
        ruleBeingHandled = rulesList[index]
        selectedRuleIndex = index
        titleTextFileld.text = rulesList[index].title
        startDatePicler.date = prepareDate(dateString: rulesList[index].startsAt!)
        endDatePicker.date = prepareDate(dateString: rulesList[index].endsAt!)
        disountAmountTextField.text = rulesList[index].value
        if rulesList[index].valueType == "fixed_amount" {
            typeSegmentedControl.selectedSegmentIndex = 1
        }else{
            typeSegmentedControl.selectedSegmentIndex = 0
        }
        usageLimitTextField.text = String(rulesList[index].usageLimit!)
        minimumSubtotalTextField.text = rulesList[index].prerequisiteSubtotalRange?.greaterThanOrEqualTo
    }
    
    func prepareDate(dateString: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:dateString)!
        return date
    }
}
