//
//  AppViewController.swift
//  AppStore
//
//  Created by 최진안 on 2023/05/20.
//

import SnapKit
import UIKit

final class AppViewController: UIViewController {
    
    // scrollView안에 contentView가 포함될것이다.
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // MARK: - stackView 선언
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        // stackview의 spacing 처리 (간격 동일)
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.0
        
        // 새로운 경험, 앱의 랭킹, 코드 교환 -> 총 3개의 section이 필요하니 View를 3개 선언해 준다.
        let featureSectionView = FeatureSectionView(frame: .zero) //내가 만든 클래스인 FeatureSectionView()로 선언을 바꿔준다. 기본은 UIView()
        let rankingFeatureSectionView = RankingFeatureSectionView(frame: .zero)
        let exchangeCodeButtonView = UIView()
        
        exchangeCodeButtonView.backgroundColor = .red
        
        // stackView에 이 3개의 섹션 뷰를 올려준다.
        [
            featureSectionView,
            rankingFeatureSectionView,
            exchangeCodeButtonView
        ].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupLayout()
    }
    
}


// 매소드는 따로 분리해서 작성
private extension AppViewController {
    func setupNavigationController() {
        navigationItem.title = "앱"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupLayout() {
        // AppViewController의 가장 기본 view 위에 subview로 scrollView를 올린다.
        view.addSubview(scrollView)
        // scrollview를 얹었을때 네비게이션 컨트롤러가 같이 있어서 autolayout이 어긋나서 아래 코드로 수정을 해준다.
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            
        }
        
        // 다음으로 scrollView위에 contentView를 올린다.
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            // $0.height.equalToSuperview() // 이렇게하면 높이는 고정 가로 스크롤만 가능
            $0.width.equalToSuperview() // 이렇게하면 너비는 고정 세로 스크롤만 가능
        }
        
        // 이제 contentView위에 stackView를 올린다.
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    
}
