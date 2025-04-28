//
//  OnboardingViewController.swift
//  MedView
//
//  Created by Алексей on 28.04.2025.
//

import UIKit
import SwiftUI
import Lottie

final class OnboardingViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let numberOfPages = 3
        
        static let pageControlRadius: CGFloat = 12
        static let pageControlOffsetBottom: CGFloat = 20
        
        static let firstMessageBubbleOffsetTop: CGFloat = 100
        static let firstMessageBubbleOffsetLeft: CGFloat = 15
        static let firstMessageBubbleCornerRadius: CGFloat = 15
        
        static let parameterWrapOffsetH: CGFloat = 15
        static let parametersLabelFont: UIFont = .systemFont(ofSize: 20, weight: .medium)
        static let parameterWrapRadius: CGFloat = 10
        
        static let parametersLabelLeftOffset: CGFloat = 25
        static let parametersLabelRightOffset: CGFloat = 5
        
        static let iconLeftOffset: CGFloat = 15
        static let iconWidth: CGFloat = 20
        
        static let firstParameterOffsetTop: CGFloat = 45
        static let secondParameterOffsetTop: CGFloat = 10
        
        static let secondMessageBubbleOffsetTop: CGFloat = 30
        
        static let messageTextViewOffsetH: CGFloat = 10
        static let messageTextViewFont: UIFont = UIFont.systemFont(ofSize: 18)
        
        static let graphOffsetHeight: CGFloat = 300
        static let graphOffsetTop: CGFloat = 20
        static let graphOffsetRight: CGFloat = 5
        
        static let thirdMessageOffsetRight: CGFloat = 35
        
        static let notificationOffsetTop: CGFloat = 40
        
        static let pickerContainerRadius: CGFloat = 15
        static let pickerContainerSize: CGFloat = 300
        static let pickerContainerTop: CGFloat = 30
        
        static let settingsLabelOffsetLeft: CGFloat = 25
        static let settingsLabelOffsetRight: CGFloat = 65
        static let settingsLabelFont: UIFont = .systemFont(ofSize: 20, weight: .medium)
        
        static let assistantIconHeight: CGFloat = 200
        static let assistantIconWidth: CGFloat = 250
        static let assistantLabelOffsetTop: CGFloat = 15
        static let assistantLabelOffsetH: CGFloat = 25
        static let assistantLabelFont: UIFont = .systemFont(ofSize: 32, weight: .medium)
        
        static let startButtonOffsetBottom: CGFloat = 100
        static let startButtonOffsetH: CGFloat = 110
        static let startButtonWidth: CGFloat = 170
        static let startButtonHeight: CGFloat = 45
        static let startButtonRadius: CGFloat = 15
        static let startButtonShadowRadius: CGFloat = 2
        static let startButtonShadowOpacity: Float = 0.5
        static let startButtonShadowHeight: CGFloat = 2
        
        static let animationSize: CGFloat = 30
        static let animationOffsetRight: CGFloat = 20
        static let animationOffsetTop: CGFloat = 5
        
        static let startTitleLabelOffsetLeft: CGFloat = 20
        
        static let startButtonTextFont: UIFont = .systemFont(ofSize: 18, weight: .bold)
    }

    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let pageControl = UIPageControl()
    let appearance: UINavigationBarAppearance = UINavigationBarAppearance()
    var hostingController: UIHostingController<ChartView> = UIHostingController(rootView: ChartView(data: [], color: .main))
    var timePicker = UIDatePicker()
    var pickerContainerView = UIView()
    var startButton: UIButton = UIButton(type: .system)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPrimary
        configureUI()
    }

    // MARK: - Functions
    private func configureUI() {
        setupScrollView()
        setupPages()
        setupPageControl()
        configureNavigationItems()
    }
    
    private func setupScrollView() {
        scrollView.frame = view.bounds
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.isScrollEnabled = true
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(Constants.numberOfPages), height: view.frame.height)
        view.addSubview(scrollView)
    }

    private func setupPages() {
        for i in 0..<Constants.numberOfPages {
            switch i {
            case 0:
                setupFirstPage(index: i)
            case 1:
                setupSecondPage(index: i)
            case 2:
                setupThirdPage(index: i)
            default:
                break
            }
        }
    }
    
    private func setupFirstPage(index: Int) {
        let page = UIView()
        page.frame = CGRect(x: CGFloat(index) * view.frame.width,
                            y: 0,
                            width: view.frame.width,
                            height: view.frame.height)
        page.backgroundColor = .backgroundPrimary
        scrollView.addSubview(page)
        
        let firstMessageBubble = configureMessageView(advice: "Enter your parameters")
        page.addSubview(firstMessageBubble)
        firstMessageBubble.pinTop(to: page, Constants.firstMessageBubbleOffsetTop)
        firstMessageBubble.pinLeft(to: page, Constants.firstMessageBubbleOffsetLeft)
        
        let firstParameter = configureParameter(parameter: .saturation)
        page.addSubview(firstParameter)
        firstParameter.pinTop(to: firstMessageBubble.bottomAnchor, Constants.firstParameterOffsetTop)
        firstParameter.pinHorizontal(to: page, Constants.parameterWrapOffsetH)
        
        let secondParameter = configureParameter(parameter: .sleepHours)
        page.addSubview(secondParameter)
        secondParameter.pinTop(to: firstParameter.bottomAnchor, Constants.secondParameterOffsetTop)
        secondParameter.pinHorizontal(to: page, Constants.parameterWrapOffsetH)
        
        let secondMessageBubble = configureMessageView(advice: "And enjoy graphics")
        page.addSubview(secondMessageBubble)
        secondMessageBubble.pinTop(to: secondParameter.bottomAnchor, Constants.secondMessageBubbleOffsetTop)
        secondMessageBubble.pinLeft(to: page, Constants.firstMessageBubbleOffsetLeft)
        
        setupChart()
        page.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: secondMessageBubble.bottomAnchor, constant: Constants.graphOffsetTop),
            hostingController.view.leadingAnchor.constraint(equalTo: page.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: page.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.graphOffsetRight),
            hostingController.view.heightAnchor.constraint(equalToConstant: Constants.graphOffsetHeight)
        ])
    }
    
    private func setupSecondPage(index: Int) {
        let page = UIView()
        page.frame = CGRect(x: CGFloat(index) * view.frame.width,
                            y: 0,
                            width: view.frame.width,
                            height: view.frame.height)
        let testWrap = UIView()
        page.addSubview(testWrap)
        page.backgroundColor = .backgroundPrimary
        scrollView.addSubview(page)
        let firstMessageBubble = configureMessageView(advice: "Tap on notification and set timestamps.\n"
                                                      + "You can also create custom your notifications and delete them with left swipe.")
        page.addSubview(firstMessageBubble)
        firstMessageBubble.pinTop(to: page, Constants.firstMessageBubbleOffsetTop)
        firstMessageBubble.pinLeft(to: page, Constants.firstMessageBubbleOffsetLeft)
        firstMessageBubble.pinRight(to: page.trailingAnchor, Constants.thirdMessageOffsetRight)
        
        let notification = configureNotification()
        page.addSubview(notification)
        notification.pinTop(to: firstMessageBubble.bottomAnchor, Constants.notificationOffsetTop)
        notification.pinHorizontal(to: page, Constants.parameterWrapOffsetH)
        
        configureTimePicker()
        page.addSubview(pickerContainerView)
        pickerContainerView.translatesAutoresizingMaskIntoConstraints = false

        pickerContainerView.pinTop(to: notification.bottomAnchor, Constants.pickerContainerTop)
        NSLayoutConstraint.activate([
            pickerContainerView.centerXAnchor.constraint(equalTo: page.centerXAnchor)
        ])
        pickerContainerView.setWidth(Constants.pickerContainerSize)
        pickerContainerView.setHeight(Constants.pickerContainerSize)
    }
    
    private func setupThirdPage(index: Int) {
        let page = UIView()
        page.frame = CGRect(x: CGFloat(index) * view.frame.width,
                            y: 0,
                            width: view.frame.width,
                            height: view.frame.height)

        page.backgroundColor = .backgroundPrimary
        scrollView.addSubview(page)
        
        let firstMessageBubble = configureMessageView(advice: "And get health advices from assistant!")
        page.addSubview(firstMessageBubble)
        firstMessageBubble.pinTop(to: page, Constants.firstMessageBubbleOffsetTop)
        firstMessageBubble.pinRight(to: page, Constants.firstMessageBubbleOffsetLeft)
        
        let secondMessageBubble = configureMessageView(advice: "Hello, how can I help you today?")
        page.addSubview(secondMessageBubble)
        secondMessageBubble.pinTop(to: firstMessageBubble.bottomAnchor, Constants.secondMessageBubbleOffsetTop)
        secondMessageBubble.pinLeft(to: page, Constants.firstMessageBubbleOffsetLeft)
        secondMessageBubble.pinRight(to: page.trailingAnchor, Constants.thirdMessageOffsetRight)
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "stethoscope")
        imageView.tintColor = .main
        page.addSubview(imageView)
        imageView.pinCenter(to: page)
        imageView.setWidth(Constants.assistantIconWidth)
        imageView.setHeight(Constants.assistantIconHeight)
        
        let assistantLabel = UILabel()
        page.addSubview(assistantLabel)
        assistantLabel.pinTop(to: imageView.bottomAnchor, Constants.assistantLabelOffsetTop)
        assistantLabel.pinHorizontal(to: page, Constants.assistantLabelOffsetH)
        
        assistantLabel.text = "MedView Assistant"
        assistantLabel.font = Constants.assistantLabelFont
        assistantLabel.textAlignment = .center
        assistantLabel.textColor = .textPrimary
        
        page.addSubview(startButton)
        startButton.setHeight(Constants.startButtonHeight)
        startButton.pinBottom(to: page.bottomAnchor, Constants.startButtonOffsetBottom)
        startButton.pinHorizontal(to: page, Constants.startButtonOffsetH)
        configureStartButton()
        configureAnimation()
    }

    private func setupPageControl() {
        pageControl.numberOfPages = Constants.numberOfPages
        pageControl.currentPage = .zero
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)

        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.pageControlOffsetBottom),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        pageControl.backgroundColor = .navigationBackground
        pageControl.currentPageIndicatorTintColor = .textPrimary
        pageControl.layer.cornerRadius = Constants.pageControlRadius
    }
    
    private func configureNavigationItems() {
        appearance.configureWithTransparentBackground()
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.tintColor = .main
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.main]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Skip",
            style: .plain,
            target: self,
            action: #selector(skipPressed)
        )
    }
    
    private func configureMessageView(advice: String) -> UIView {
        let messageBubble = UIView()
        
        messageBubble.layer.cornerRadius = Constants.firstMessageBubbleCornerRadius
        
        let messageTextView: UITextView = UITextView()
        
        messageBubble.addSubview(messageTextView)
        messageTextView.pinHorizontal(to: messageBubble, Constants.messageTextViewOffsetH)
        messageTextView.pinVertical(to: messageBubble)
        
        if advice == "Hello, how can I help you today?" {
            messageTextView.textColor = .textPrimary
            messageBubble.backgroundColor = .cellBackground
        } else {
            messageTextView.textColor = .white
            messageBubble.backgroundColor = UIColor.main
        }
        
        messageTextView.backgroundColor = .clear
        messageTextView.layer.cornerRadius = Constants.firstMessageBubbleCornerRadius
        messageTextView.font = Constants.messageTextViewFont
        messageTextView.textAlignment = .left
        messageTextView.isScrollEnabled = false
        messageTextView.isEditable = false
        messageTextView.isSelectable = true
        messageTextView.text = advice
        
        return messageBubble
    }
    
    private func configureParameter(parameter: MedParameterType) -> UIView {
        let parameterView = UIView()
        parameterView.backgroundColor = UIColor.cellBackground
        parameterView.layer.cornerRadius = Constants.parameterWrapRadius
        
        let icon: UIImageView = UIImageView()
        let parametersLabel: UILabel = UILabel()
        
        icon.contentMode = .scaleAspectFill
        icon.image = UIImage(named: parameter.rawValue)
        if parameter == .sleepHours {
            icon.tintColor = .sleepHours
        } else {
            icon.tintColor = .saturation
        }
        
        parameterView.addSubview(icon)
        
        icon.pinTop(to: parameterView.layoutMarginsGuide.topAnchor)
        icon.pinBottom(to: parameterView.layoutMarginsGuide.bottomAnchor)
        icon.pinLeft(to: parameterView, Constants.iconLeftOffset)
        icon.setWidth(Constants.iconWidth)
        
        parametersLabel.textColor = UIColor.textPrimary
        parametersLabel.textAlignment = .left
        parametersLabel.font = Constants.parametersLabelFont
        parametersLabel.text = parameter.rawValue
        
        parameterView.addSubview(parametersLabel)
        
        parametersLabel.pinTop(to: parameterView.layoutMarginsGuide.topAnchor)
        parametersLabel.pinBottom(to: parameterView.layoutMarginsGuide.bottomAnchor)
        parametersLabel.pinLeft(to: icon.trailingAnchor, Constants.parametersLabelLeftOffset)
        parametersLabel.pinRight(to: parameterView, Constants.parametersLabelRightOffset)
        
        return parameterView
    }
    
    private func setupChart() {
        let customData: [(date: String, value: Double)] = [
            ("2025-04-19 12:00", 9.0),
            ("2025-04-20 09:33", 7.0),
            ("2025-04-21 10:00", 8.2),
            ("2025-04-22 14:00", 5.0),
            ("2025-04-23 9:00", 6.7),
            ("2025-04-24 9:45", 7.5),
            ("2025-04-25 13:00", 7.0),
            ("2025-04-26 11:30", 4.7),
            ("2025-04-27 10:50", 6.0)
        ]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        let chartDataPoints: [ChartDataPoint] = customData.compactMap { data in
            guard let date = dateFormatter.date(from: data.date) else {
                return nil
            }
            return ChartDataPoint(date: date, value: data.value)
        }
        
        let chartView = ChartView(data: chartDataPoints, color: Color(UIColor.sleepHours))
        hostingController.rootView = chartView
        addChild(hostingController)
        hostingController.didMove(toParent: self)
    }
    
    private func configureNotification() -> UIView {
        let notificationView = UIView()
        
        let settingsLabel: UILabel = UILabel()
        let settingsSwitch: UISwitch = UISwitch()
        
        notificationView.layer.cornerRadius = Constants.parameterWrapRadius
        notificationView.backgroundColor = .cellBackground
        
        notificationView.addSubview(settingsLabel)
        settingsLabel.textColor = .textPrimary
        settingsLabel.textAlignment = .left
        settingsLabel.font = Constants.parametersLabelFont
        settingsLabel.text = "Notification"
        
        settingsLabel.pinTop(to: notificationView.layoutMarginsGuide.topAnchor)
        settingsLabel.pinBottom(to: notificationView.layoutMarginsGuide.bottomAnchor)
        settingsLabel.pinLeft(to: notificationView, Constants.settingsLabelOffsetLeft)
        settingsLabel.pinRight(to: notificationView, Constants.settingsLabelOffsetRight)
        
        notificationView.addSubview(settingsSwitch)
        settingsSwitch.pinLeft(to: settingsLabel.trailingAnchor)
        settingsSwitch.pinTop(to: notificationView.layoutMarginsGuide.topAnchor)
        settingsSwitch.pinBottom(to: notificationView.layoutMarginsGuide.bottomAnchor)
        settingsSwitch.isOn = true
        settingsSwitch.onTintColor = .main
        
        return notificationView
    }
    
    private func configureTimePicker() {
        pickerContainerView.backgroundColor = .backgroundPrimary
        pickerContainerView.layer.cornerRadius = Constants.pickerContainerRadius
        pickerContainerView.clipsToBounds = true
        
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        
        timePicker.date = Date()

        pickerContainerView.addSubview(timePicker)
        timePicker.pinHorizontal(to: pickerContainerView)
        timePicker.pinVertical(to: pickerContainerView)
    }
    
    private func configureStartButton() {
        startButton.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        guard let titleLabel = startButton.titleLabel else { return }
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: startButton.leadingAnchor, constant: Constants.startTitleLabelOffsetLeft),
            titleLabel.centerYAnchor.constraint(equalTo: startButton.centerYAnchor)
        ])
        startButton.setTitle("Get started", for: .normal)
        startButton.tintColor = .textPrimary
        startButton.titleLabel?.font = Constants.startButtonTextFont
        startButton.titleLabel?.textAlignment = .left
        startButton.backgroundColor = .cellBackground
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        
        startButton.layer.cornerRadius = Constants.startButtonRadius
        startButton.layer.shadowColor = UIColor.textPrimary.cgColor
        startButton.layer.shadowOffset = CGSize(
            width: .zero,
            height: Constants.startButtonShadowHeight
        )
        startButton.layer.shadowOpacity = Constants.startButtonShadowOpacity
        startButton.layer.shadowRadius = Constants.startButtonShadowRadius
    }
    
    private func configureAnimation() {
        let animationView = LottieAnimationView(name: "HealthLoadAnimation")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .autoReverse
        animationView.play()
        startButton.addSubview(animationView)
        animationView.pinRight(to: startButton.trailingAnchor, Constants.animationOffsetRight)
        animationView.pinTop(to: startButton.topAnchor, Constants.animationOffsetTop)
        animationView.setWidth(Constants.animationSize)
        animationView.setHeight(Constants.animationSize)
    }
    
    private func triggerSelectionFeedback() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    // MARK: - Actions
    @objc private func skipPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func startButtonPressed() {
        triggerSelectionFeedback()
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - UIScrollViewDelegate
extension OnboardingViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = 0
        
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
