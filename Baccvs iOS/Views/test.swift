//
//  test.swift
//  Baccvs iOS
//  Created by pm on 05/02/2023.
//import SwiftUI
//struct Content: View {
//    @State private var refCode = ""
//    @State private var currentPage = 0
//    var body: some View {
//        VStack {
//            ZStack{
//                Rectangle()
//                    .frame(width: 300, height: 10)
//                    .opacity(0.3)
//                    .foregroundColor(Color.gray)
//
//                Rectangle()
//                    .frame(width: 300 * CGFloat(currentPage) * 0.2 + 60, height: 10)
//                    .foregroundColor(color(for: currentPage))
//            }
//            if currentPage < pages.count {
//                pages[currentPage]
//                    .transition(.slide)
//            }
//
//            Button(action: {
//                if self.currentPage < self.pages.count - 1 {
//                    self.currentPage += 1
//                }
//            }) {
//                Text("Next")
//            }
//        }
//    }
//
//    private func color(for index: Int) -> Color {
//        switch index {
//        case 0:
//            return .red
//        case 1:
//            return .green
//        case 2:
//            return .blue
//        case 3:
//            return .yellow
//        case 4:
//            return .purple
//        default:
//            return .gray
//        }
//    }
//
//    private let pages: [AnyView] = [
//        AnyView(Text("p1")),
//        AnyView(Text("p2")),
//        AnyView(Text("p3")),
//        AnyView(Text("p4")),]
//}
//import SwiftUI
//
//struct Test: View {
//    @StateObject var testVM = TestViewModel()
//
//    var body: some View {
//        VStack{
//            List(testVM.getAllEvents, id: \.id){ n in
//                HStack{
//                    AsyncImage(url: URL(string: n.tum_nail ?? "")) { img in
//                        img
//                            .resizable()
//                            .scaledToFit()
//                    } placeholder: {
//                        ProgressView()
//                    }.frame(width: 50, height: 50, alignment: .center)
//
//                    Text(n.mobile_number)
//                }
//            }
//        }
//    }
//}
//                struct testtest: Codable {
//                    let id, name, email: String
//                    let profileImageURL: String
//                    let referralCodeByNextUser, instagram, dateOfBirth, gender: String
//                    let otp, zodaic, longitude, latitude: String
//                    let jobTitle, school, languages, drinking: String
//                    let smoking, drugs, createdAt: String
//
//                    enum CodingKeys: String, CodingKey {
//                        case id, name, email
//                        case profileImageURL = "profile_image_url"
//                        case referralCodeByNextUser = "referral_code_by_next_user"
//                        case instagram
//                        case dateOfBirth = "date_of_birth"
//                        case gender, otp, zodaic, longitude, latitude
//                        case jobTitle = "job_title"
//                        case school, languages, drinking, smoking, drugs
//                        case createdAt = "created_at"
//                    }
//                }
import SwiftUI
import UIKit

/// A custom scroll view that supports pull to refresh using the `refreshable()` modifier.
public struct RefreshableScrollView<Content: View>: View {
  let refreshControl: () -> UIRefreshControl
  @ViewBuilder let content: () -> Content

  public init(
    refreshControl: @autoclosure @escaping () -> UIRefreshControl = .init(),
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.refreshControl = refreshControl
    self.content = content
  }

  public var body: some View {
    GeometryReader { proxy in
      ScrollViewControllerRepresentable(refreshControl: refreshControl()) {
        content()
          .frame(width: proxy.size.width)
      }
      .ignoresSafeArea()
    }
  }
}

struct ScrollViewControllerRepresentable<Content: View>: UIViewControllerRepresentable {
  let refreshControl: UIRefreshControl
  @ViewBuilder let content: () -> Content
  @Environment(\.refresh) private var action
  @State var isRefreshing: Bool = false

  init(refreshControl: UIRefreshControl, @ViewBuilder content: @escaping () -> Content) {
    self.refreshControl = refreshControl
    self.content = content
  }

  func makeUIViewController(context: Context) -> ScrollViewController<Content> {
    let viewController = ScrollViewController(
      refreshControl: refreshControl,
      view: content()
    )
    viewController.onRefresh = {
      refresh()
    }
    return viewController
  }

  func updateUIViewController(_ viewController: ScrollViewController<Content>, context: Context) {
    viewController.hostingController.rootView = content()
    viewController.hostingController.view.setNeedsUpdateConstraints()

    if isRefreshing {
      viewController.refreshControl.beginRefreshing()
    } else {
      viewController.refreshControl.endRefreshing()
    }
  }

  func refresh() {
    Task {
      isRefreshing = true
      await action?()
      isRefreshing = false
    }
  }
}

class ScrollViewController<Content: View>: UIViewController, UIScrollViewDelegate {
  let scrollView = UIScrollView()
  let refreshControl: UIRefreshControl
  let hostingController: UIHostingController<Content>

  var onRefresh: (() -> Void)?

  init(refreshControl: UIRefreshControl, view: Content) {
    self.refreshControl = refreshControl
    hostingController = .init(rootView: view)
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    view = scrollView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)

    scrollView.refreshControl = refreshControl
    scrollView.delegate = self

    hostingController.willMove(toParent: self)

    scrollView.addSubview(hostingController.view)
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      hostingController.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      hostingController.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
    ])

    // `addChild` must be called *after* the layout constraints have been set, or a layout bug will occur
    addChild(hostingController)
    hostingController.didMove(toParent: self)
    hostingController.view.backgroundColor = .clear
  }

  @objc func didPullToRefresh(_ sender: UIRefreshControl) {
    onRefresh?()
  }
}
