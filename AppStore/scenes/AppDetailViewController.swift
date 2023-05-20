//
//  AppDetailViewController.swift
//  AppStore
//
//  Created by 최진안 on 2023/05/20.
//

import SnapKit
import UIKit

/**
 투데이 탭에서 > 앱 클릭시 > 상세보기 화면이 나오는 컨트롤러
 */
final class AppDetailViewController: UIViewController {
    
    // 앱 이미지 뷰
    private let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        // imageView보다 큰 이미지가 들어와도 넘치지 않게 해준다.
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8.0
        
        return imageView
    }()
    
    // 상세제목 라벨
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .label //darkmode에서도 대응가능한 텍스트라벨 색상이다.
        
        return label
    }()
    
    // 부가설명 라벨
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    // 다운로드(받기) 버튼 구현
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("닫기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12.0
        
        return button
    }()
    
    // 공유하기 버튼 구현
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemBlue
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // darkmode가 있다.그래서 이렇게 설정함 이슈를 없애기 위해
        view.backgroundColor = .systemBackground
     
        setupViews()
        
        appIconImageView.backgroundColor = .lightGray
        titleLabel.text = "title"
        subTitleLabel.text = "Sub title"
    }
}

// MARK: - layout 설정 확장선언
private extension AppDetailViewController {
    
    func setupViews() {
        [
            appIconImageView,
            titleLabel,
            subTitleLabel,
            downloadButton,
            shareButton
        ].forEach { view.addSubview($0) }
        
        appIconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(32.0)
            $0.height.equalTo(100.0)
            $0.width.equalTo(appIconImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(appIconImageView.snp.top)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        downloadButton.snp.makeConstraints {
            $0.bottom.equalTo(appIconImageView.snp.bottom)
            $0.height.equalTo(24.0)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.width.equalTo(60.0)
        }

        shareButton.snp.makeConstraints {
            $0.bottom.equalTo(appIconImageView.snp.bottom)
            $0.height.equalTo(32.0)
            $0.trailing.equalTo(titleLabel.snp.trailing)
            $0.width.equalTo(32.0)
        }
        
        
    }
    
}
