//
//  AIGlobals.swift
//  Swift3CodeStructure
//
//  Created by Ravi Alagiya on 25/11/2016.
//  Copyright © 2016 Ravi Alagiya. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds
import Localize_Swift

//MARK: - GENERAL
let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate

//MARK: - MANAGERS
//let ServiceManager = AIServiceManager.sharedManager

//MARK:- Storyboard Outlet
let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)


//MARK: - APP SPECIFIC

let APP_SECRET = ""
let appID = ""
let userDefault = UserDefaults.standard
let USER_COIN = "UserCoin"
let ADS_PRESENT_COUNT = "adsPresentCount"
let ADS_FAIL_COUNT = "adsFailCount"
let ADS_SUCESS_COUNT = "adsSucessCount"
let ARRAY_PUZZLE_STAGES = "ARRAY_PUZZLE_STAGES"
var APPSTOREURL = "https://apps.apple.com/us/app/kids-word-puzzle/id6443554153"
let FeedbackEmail = "info@hash-mob.com"
let feedbackMessageBody = """
App name: WordPuzzle

Device: iPhone
OS Version: \(UIDevice.current.systemVersion)
"""
let feedbackSubject = "Support: ".localized() + "WordPuzzle"

//MARK: - ONESIGNAL KEY
var ONESIGNAL_APP_ID = "ac1dfb44-42b5-42a9-b4a4-eb924ac8d035"

//MARK: - Google AD ID
// Test Ads
let GBInterstitialAdId = "ca-app-pub-3940256099942544/4411468910"
let GBRewardID = "ca-app-pub-3940256099942544/1712485313"
let GBAppOpenID =  "ca-app-pub-3940256099942544/5662855259"
let GBBannerID =   "ca-app-pub-3940256099942544/6300978111"
let bannerSize = UIDevice.current.userInterfaceIdiom == .pad ? GADAdSizeFullBanner : GADAdSizeBanner

//MARK: - ERROR
let CUSTOM_ERROR_DOMAIN = "CUSTOM_ERROR_DOMAIN"
let CUSTOM_ERROR_USER_INFO_KEY = "CUSTOM_ERROR_USER_INFO_KEY"
let DEFAULT_ERROR = "Something went wrong, please try again later.".localized()
let INTERNET_ERROR = "Please check your internet connection and try again.".localized()

let VERSION_NUMBER = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
let BUILD_NUMBER = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
var SYSTEM_VERSION = UIDevice.current.systemVersion
var DEVICE_UUID = UIDevice.current.identifierForVendor?.uuidString

// MARK: - KEYS FOR USERDEFAULTS
let isUpgradePlan = "isUpgradePlan"
let NOTIFICATION_SWITCH = "NOTIFICATION_SWITCH"
let PUZZEL_USING_IMAGE_OR_SOUND = "PUZZEL_USING_IMAGE_OR_SOUND"
let ADD_FREE_OR_NOT = "ADD_FREE_OR_NOT"
let SOUND_OFF = "SOUND_OFF"
let SPEAK_KEYWORD = "SPEAK_KEYWORD"
let AKLATITUDE = "AKLATITUDE"
let AKLONGITUDE = "AKLONGITUDE"
let AKLOCATION = "AKLOCATION"
let PUZZLE_DATA = "puzzleData"
let FIREBASE_DATA = "firebaseData"
let IS_UPDATE_FIREBASE_INFO = "isUpdateFirbaseInfo"
let ALERT_SOME_THINGS = "Something went wrong. Please try again.".localized()

//MARK: - COLORS
let APP_BLACK                    = UIColor(named: "APP_BLACK_COLOR")
let APP_GREY                     = UIColor(named: "APP_GREY")
let APP_WHITE                    = UIColor(named: "APP_WHITE")
let APP_RED_COLOR                    = UIColor(named: "APP_RED_COLOR")!
let APP_ORANGE_COLOR                    = UIColor(named: "APP_ORANGE_COLOR")!
let APP_GREEN_COLOR                    = UIColor(named: "APP_GREEN_COLOR")
let APP_LIGHT_GREY               = UIColor(named: "APP_BLACK_COLOR")!

//MARK:-  fonts
let FONT_JANDACLOSER_BLACK     = "JandaCloserToFree"
let FONT_GAMERIA     = "GAMERIA"
let FONT_GUAVA_CANDY     = "Guava Candy"
let FONT_HelveticaRoundedLTStd_BdCn     = "HelveticaRoundedLTStd-BdCn"
let FONT_HelveticaRoundedLTStd_Bd     = "HelveticaRoundedLTStd-Bd"
let FONT_HelveticaRoundedLTStd_BLACK     = "HelveticaRoundedLTStd-Black"

