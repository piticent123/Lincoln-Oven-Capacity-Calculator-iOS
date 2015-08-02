//
//  CapacityCalculatorView.swift
//  Lincoln Ovens
//
//  Created by Jordan Pitlor on 7/28/15.
//  Copyright (c) 2015 Manitowoc Foodservice. All rights reserved.
//

import Foundation
import UIKit

public class CapacityCalculatorView: UIViewController, UIActionSheetDelegate {
	@IBOutlet weak var panType: UISegmentedControl!
	@IBOutlet weak var beltWidth: UITextField!
	@IBOutlet weak var chamberLength: UITextField!
	@IBOutlet weak var bakeTime: UITextField!
	@IBOutlet weak var panDiameterOrLength: UITextField!
	@IBOutlet weak var panWidth: UITextField!
	@IBOutlet weak var widthLabel: UILabel!
	@IBOutlet weak var diameterOrLengthLabel: UILabel!

	@IBAction func calculateButtonClicked(sender: UIButton) {
		if errorCheck() {
			let BW = Double(beltWidth.text.toInt()!)
			let CL = Double(chamberLength.text.toInt()!)
			let BT = Double(bakeTime.text.toInt()!)
			let c: CapacityCalculator

			if panType.selectedSegmentIndex == 0 {
				let PD = Double(panDiameterOrLength.text.toInt()!)

				c = CapacityCalculator(beltWidth: BW, ovenCapacity: CL, bakeTime: BT, panDiameter: PD)
			} else {
				let PL = Double(panDiameterOrLength.text.toInt()!)
				let PW = Double(panWidth.text.toInt()!)

				c = CapacityCalculator(beltWidth: BW, ovenCapacity: CL, bakeTime: BT, panWidth: PW, panLength: PL)
			}

			let capacity: Double = c.calculateCapacity()
			let popup: UIAlertController = UIAlertController(title: "The capacity is " + String(format: "%.1f", capacity) + " pans/hour", message: nil, preferredStyle: .Alert)
			let OKAction = UIAlertAction(title: "OK", style: .Default) {
				(action) in
				// Do nothing
			}
			popup.addAction(OKAction)
			self.presentViewController(popup, animated: true, completion: nil)
		} else {
			let popup: UIAlertController = UIAlertController(title: "Inputs Missing", message: "Please fill out all of the inputs, then try calculating the capacity again", preferredStyle: .Alert)
			let OKAction = UIAlertAction(title: "OK", style: .Default) {
				(action) in
				// Do nothing
			}
			popup.addAction(OKAction)
			self.presentViewController(popup, animated: true, completion: nil)
		}
	}

	private func errorCheck() -> Bool {
		if panType.selectedSegmentIndex == 0 {
			panWidth.text = "0"
		}

		return !beltWidth.text.isEmpty && !chamberLength.text.isEmpty && !bakeTime.text.isEmpty && !panDiameterOrLength.text.isEmpty && !panWidth.text.isEmpty
	}

	@IBAction func panTypeClicked(sender: AnyObject) {
		if panType.selectedSegmentIndex == 0 {
			widthLabel.hidden = true
			panWidth.hidden = true

			diameterOrLengthLabel.text = "Diameter"
			panDiameterOrLength.text = ""
		} else {
			widthLabel.hidden = false
			panWidth.hidden = false

			diameterOrLengthLabel.text = "Length"
			panDiameterOrLength.text = ""
			panWidth.text = ""
		}
	}

	override public func viewDidLoad() {
		let pickModel = UIBarButtonItem(title: "Choose Model", style: .Plain, target: self, action: "chooseModel:")
		self.navigationItem.rightBarButtonItem = pickModel
	}

    public func chooseModel(sender: AnyObject) {
//        let popup: UIActionSheet = 	UIActionSheet(title: "Choose a Model", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "2500", "1100", "1400/1600/3240", "3255", "3270", nil)
//        popup.showFromBarButtonItem(self.navigationItem.rightBarButtonItem, animated: true)
        
		let alert = UIAlertController(title: "Choose a Model", message: nil, preferredStyle: .ActionSheet)

		let buttonOne = UIAlertAction(title: "2500", style: .Default, handler: {
			(action) -> Void in
			self.beltWidth.text = "16"
            self.chamberLength.text = "20.5"
		})
		let buttonTwo = UIAlertAction(title: "1100", style: .Default, handler: {
			(action) -> Void in
			self.beltWidth.text = "18"
            self.chamberLength.text = "28.25"
		})
		let buttonThree = UIAlertAction(title: "1400/1600/3240", style: .Default, handler: {
			(action) -> Void in
			self.beltWidth.text = "32"
            self.chamberLength.text = "40.1875"
		})
		let buttonFour = UIAlertAction(title: "3255", style: .Default, handler: {
			(action) -> Void in
			self.beltWidth.text = "32"
            self.chamberLength.text = "55"
		})
		let buttonFive = UIAlertAction(title: "3270", style: .Default, handler: {
			(action) -> Void in
			self.beltWidth.text = "32"
            self.chamberLength.text = "70"
		})
		let buttonCancel = UIAlertAction(title: "Cancel", style: .Cancel) {
			(action) -> Void in
			// Do nothing
		}

        alert.addAction(buttonOne)
        alert.addAction(buttonTwo)
        alert.addAction(buttonThree)
        alert.addAction(buttonFour)
        alert.addAction(buttonFive)
        alert.addAction(buttonCancel)
        
        self.presentViewController(alert, animated: true, completion: nil)
	}

}