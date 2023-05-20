//
//  TabBarController.swift
//  AppStore
//
//  Created by 최진안 on 2023/05/18.
//

import UIKit


/**
   이렇게 todayViewController, appViewController를 클로저 형태로 선언해서 하단의 탭바를 하나씩 선언해준 클래스다.
 */
class TabBarController: UITabBarController {
    
    // MARK: - [투데이] 라는 탭을 하단에 보이도록 선언
    private lazy var todayViewController: UIViewController = {
        // viewController를 내가 만든 TodayViewController로 설정해 준다.
        let viewController = TodayViewController()
        // 첫번째 탭이라 tag:0이다.
        let tabBarItem = UITabBarItem(title: "투데이", image: UIImage(systemName: "mail"), tag: 0)
        viewController.tabBarItem = tabBarItem
        
        return viewController
    }()
    
    // MARK: - [앱] 이라는 탭을 하단에 보이도록 선언
    private lazy var appViewController: UIViewController = {
        // Navigation을 상단에 추가하기 위해 UINavigationController()를 사용한다.
        let viewController = UINavigationController(rootViewController: AppViewController())
        
        let tabBarItem = UITabBarItem(title: "앱", image: UIImage(systemName: "square.stack.3d.up"), tag: 1)
        viewController.tabBarItem = tabBarItem
        
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [todayViewController, appViewController]
    }


}

