//
//  UIViewController+Extension.swift
//  Doctor
//
//  Created by Jaydeep on 02/07/19.
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController: UIGestureRecognizerDelegate {
        
    //MARK:- Action Zone
    
    @IBAction func btnBackAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    
    //MARK:- SetupNavigation bar
    @objc func backAction() {
         self.navigationController?.popViewController(animated: true)
    }
    

    func setupNavigationBarWitMenuButton(_ name:String,isBackHidden:Bool = true){
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        let btnBackTitle = UIBarButtonItem(title: name, style: .plain, target: self, action: #selector(btnBackAction(_:)))
        btnBackTitle.setTitleTextAttributes([NSAttributedString.Key.font : themeFont(size: 20, fontname: .bold)], for: .normal)
        btnBackTitle.tintColor = UIColor(named: "APP_BLACK")
        
        if isBackHidden {
            self.navigationItem.leftBarButtonItems = [btnBackTitle]
        } else {
            let btnBack = UIBarButtonItem(image: UIImage(named: "ic_back"), style: .plain, target: self, action: #selector(btnBackAction(_:)))
            btnBack.tintColor = UIColor(named: "APP_BLACK")
            self.navigationItem.leftBarButtonItems = [btnBack,btnBackTitle]
        }
        
    }
    
    func setupRightMenu(){
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "ic_finish"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 126, height: 32)
        btn1.addTarget(self, action: #selector(btnRightAction(_:)), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.rightBarButtonItems = [item1]
        
    }
    
    func setupRightMenuRegular(){
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        let btnSort = UIButton()
        btnSort.setImage(UIImage(named: "ic_dot"), for: .normal)
        btnSort.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnSort.addTarget(self, action: #selector(btnRightAction(_:)), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: btnSort)
        
        self.navigationItem.rightBarButtonItems  = [item2]
        
//        let btnRight = UIBarButtonItem(image: UIImage(named: "ic_dot"), style: .plain, target: self, action: #selector(btnRightAction(_:)))
//        btnRight.tintColor = UIColor(named: "APP_BLACK")
//        self.navigationItem.rightBarButtonItems = [btnRight]
        
    }
    
    @objc func btnRightAction(_ sender:UIButton) {
        
    }
  
    @objc func dismissVC(){
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    @objc func btnMenuAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    //MARK:- Change StatusBar Background Color
    func changeStatusBarBackgroundColor(color:UIColor) {
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = color
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
          
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = color
        }
    }
    
    //MARK:- Check Valid URL
    
    func canOpenURL(_ string: String?) -> Bool {
        guard let urlString = string,
            let url = URL(string: urlString)
            else { return false }

        if !UIApplication.shared.canOpenURL(url) { return false }

        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
    
    //MARK: - StartAnimating
    func addDoneButtonOnKeyboard(textfield : UITextField)
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0,y: 0,width: UIScreen.main.bounds.width,height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem:  UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonAction))
        done.tintColor = UIColor(red: 35/255, green: 141/255, blue: 250/255, alpha: 1.0)
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        textfield.inputAccessoryView = doneToolbar
        
    }
    
    @objc func doneButtonAction()
    {
        self.view.endEditing(true)
    }
    
    //MARK: - Date
    func StringToDate(Formatter : String,strDate : String) -> Date
    {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = Formatter
//        dateformatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let convertedDate = dateformatter.date(from: strDate) else {
            let str = dateformatter.string(from: Date())
            return dateformatter.date(from: str)!
            
        }
        //        print("convertedDate - ",convertedDate)
        return convertedDate
    }
    
    func utcToLocal(strToFormate:String, dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = strToFormate
        
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    
    func getDateFromUTCTime(strDate:String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let date = dateFormatter.date(from: strDate) else {
            return nil
        }
        return date
    }

    
    func getElapsedInterval(fromDate:Date) -> String {

        let interval = Calendar.current.dateComponents([.year, .month, .day], from: fromDate, to: Date())

        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" :
                "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" :
                "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" :
                "\(day)" + " " + "days ago"
        } else {
            return "a moment ago"

        }

    }
    
    
    func DateToString(Formatter : String,date : Date) -> String
    {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = Formatter
        
        //    dateformatter.timeZone = TimeZone(abbreviation: "UTC")
        let convertedString = dateformatter.string(from: date)
        return convertedString
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    */
}

/*
//MARK:- UITableCell Extension

extension UITableViewCell {
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(_ label: UILabel, targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x:(labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y:(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x:locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y : locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}

extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: lineWidth))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension TimeInterval {
    var time: String {
        return String(format:"%02d:%02d", Int(self/60),  Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}

extension Date {
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }
    
    var monthDigit: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M"
        return dateFormatter.string(from: self)
    }
    
}
*/
