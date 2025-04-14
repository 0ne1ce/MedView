//
//  AssistantModels.swift
//  MedView
//
//  Created by Алексей on 19.02.2025.
//
import Foundation
import UIKit

enum AssistantModels {
    enum LoadStart {
        struct Request {
            
        }
        
        struct Response {
            var titleText: NSMutableAttributedString
            var settingsImageName: String
            var placeholderText: String
            var animationName: String
        }
        
        struct ViewModel: NavigationTitleRepresentable {
            var navigationTitle: NSMutableAttributedString
            var settingsImage: UIImage?
            var placeholderText: String
            var placeholderFont: UIFont
            var placeholderColor: UIColor
            var inputWrapBackgroundColor: UIColor
            var navigationTitleFont: UIFont
            var navigationTitleColor: UIColor?
            var sendButtonColor: UIColor
            var sendButtonTintColor: UIColor
            var tableBackgroundColor: UIColor
            var animationName: String
        }
    }
    
    enum LoadSettings {
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
    
    enum EndEditing {
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
    
    enum SendUserMessage {
        struct Request {
            var userMessageText: String
        }
        
        struct Response {
            var placeholderText: String
        }
        
        struct ViewModel {
            var placeholderText: String
            var placeholderColor: UIColor
        }
    }
    
    enum SendAssistantMessage {
        struct Request {
            var userMessageText: String
        }
        
        struct Response {

        }
        
        struct ViewModel {

        }
    }
}
