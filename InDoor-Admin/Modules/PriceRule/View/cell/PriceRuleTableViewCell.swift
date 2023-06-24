//
//  PriceRuleTableViewCell.swift
//  InDoor-Admin
//
//  Created by Ahmed on 17/06/2023.
//

import UIKit

class PriceRuleTableViewCell: UITableViewCell {

    @IBOutlet weak var ruleUsageLimit: UILabel!
    @IBOutlet weak var ruleAmount: UILabel!
    @IBOutlet weak var ruleEndTime: UILabel!
    @IBOutlet weak var ruleStartTime: UILabel!
    @IBOutlet weak var ruleTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowRadius = 3.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.7
        layer.masksToBounds = false
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        backgroundColor = .clear
        contentView.backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override var frame: CGRect{
        get {
            return super.frame
        }
        set(newFrame){
            var frame = newFrame
            frame.origin.x += 8
            frame.origin.y += 8
            frame.size.width -= 2 * 8
            frame.size.height -= 2 * 8
            super.frame = frame
        }
    }
    
    func setUpPriceRuleData(rule:PriceRule){
        ruleTitle.text = rule.title
        ruleStartTime.text = prepareDate(dateString: rule.startsAt!)
        ruleEndTime.text = prepareDate(dateString: rule.endsAt!)
        ruleAmount.text = prepareAmountText(rule:rule)
        ruleUsageLimit.text = "\(String(rule.usageLimit!)) Max usages"
    }
    
    func prepareDate(dateString: String) -> String{
        let dateFormatter = DateFormatter()
          dateFormatter.locale = Locale(identifier: "en_US_POSIX")
          dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
          let date = dateFormatter.date(from:dateString)!
        return date.formatted(date: .long, time: .shortened)
    }
    
    func prepareAmountText(rule:PriceRule) -> String{
        var sign = ""
        if rule.valueType == "fixed_amount"{
            sign = "$"
        }else{
            sign = "%"
        }
        let amountText = "\(rule.value!)\(sign) After \(rule.prerequisiteSubtotalRange?.greaterThanOrEqualTo ?? "")$"
        return amountText
    }
}
