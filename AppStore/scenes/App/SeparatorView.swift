//
//  SeparatorView.swift
//  AppStore
//
//  Created by 최진안 on 2023/05/20.
//

import SnapKit
import UIKit

/**
 콜렉션 뷰나 다른 뷰의 섹션을 나누는 선을 만들어주는 클래스
 */
final class SeparatorView: UIView {
    
    // MARK: - 하단의 선을 표시할 뷰인 separator뷰를 선언
    private lazy var separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .separator
        
        return separator
    }()
    
    // MARK: - 생성자로 뷰를 addSubView를 해준다.
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(separator)
        separator.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(corder:) has not been implemented")
    }
    
}
