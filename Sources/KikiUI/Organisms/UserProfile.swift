//
//  SwiftUIView.swift
//
//
//  Created by Henry Jones on 11/30/23.
//

import SwiftUI
import DesignSystem

public enum ExternalContactType {
    case faceTime, phone
}

public protocol UserProfileViewModelDelegate: AnyObject {
    func onPressExternalContact(_ contactType: ExternalContactType)
    func onPressReport()
    func onPressMessage()
    func onPressShareProfile()
    func onPressRemoveFriend()
    func onToggleMute()
    func onToggleBlock()
}

public class UserProfileViewModel: NSObject, ObservableObject {
    @Published public var isBlocked: Bool = false
    @Published public var isMuted: Bool = false
    @Published public var title: String = "Oliver W."
    @Published public var subtitle: String = "@Oliver"
    @Published public var note: String = "Oliver Wang from your contacts"
    @Published public var bio: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    
    weak var delegate: UserProfileViewModelDelegate?
    
    // Functions passed directly
    var onPressExternalContactAction: ((ExternalContactType) -> Void)?
    var onPressReportAction: (() -> Void)?
    var onPressMessageAction: (() -> Void)?
    var onPressShareProfileAction: (() -> Void)?
    var onPressRemoveFriendAction: (() -> Void)?
    var onToggleMuteAction: (() -> Void)?
    var onToggleBlockAction: (() -> Void)?
    
    // Initializer for delegate pattern
    public init(delegate: UserProfileViewModelDelegate) {
        self.delegate = delegate
    }
    
    // Initializer for direct function assignment
    public init(onPressExternalContact: ((ExternalContactType) -> Void)? = nil,
         onPressReport: (() -> Void)? = nil,
         onPressMessage: (() -> Void)? = nil,
         onPressShareProfile: (() -> Void)? = nil,
         onPressRemoveFriend: (() -> Void)? = nil,
         onToggleMute: (() -> Void)? = nil,
         onToggleBlock: (() -> Void)? = nil) {
        
        self.onPressExternalContactAction = onPressExternalContact
        self.onPressReportAction = onPressReport
        self.onPressMessageAction = onPressMessage
        self.onPressShareProfileAction = onPressShareProfile
        self.onPressRemoveFriendAction = onPressRemoveFriend
        self.onToggleMuteAction = onToggleMute
        self.onToggleBlockAction = onToggleBlock
    }


    func onPressExternalContact(_ contactType: ExternalContactType) {
        if let action = onPressExternalContactAction {
            action(contactType)
        } else {
            delegate?.onPressExternalContact(contactType)
        }
    }
    
    func onPressReport() {
        if let action = onPressReportAction {
            action()
        } else {
            delegate?.onPressReport()
        }
    }
    
    func onPressMessage() {
        if let action = onPressMessageAction {
            action()
        } else {
            delegate?.onPressMessage()
        }
    }

    func onPressShareProfile() {
        if let action = onPressShareProfileAction {
            action()
        } else {
            delegate?.onPressShareProfile()
        }
    }

    func onPressRemoveFriend() {
        if let action = onPressRemoveFriendAction {
            action()
        } else {
            delegate?.onPressRemoveFriend()
        }
    }

    func onToggleMute() {
        if let action = onToggleMuteAction {
            action()
        } else {
            delegate?.onToggleMute()
        }
    }

    func onToggleBlock() {
        if let action = onToggleBlockAction {
            action()
        } else {
            delegate?.onToggleBlock()
        }
    }
}



public struct UserProfile: View {
//    @ObservedObject var viewModel = UserProfileViewModel()
    @ObservedObject public var viewModel: UserProfileViewModel
    
    public init(viewModel: UserProfileViewModel) {
        self.viewModel = viewModel
    }

    // Initializer for testing that creates its own UserProfileViewModel
    public init() {
        // Here you can provide default or mock data for the view model
        self.viewModel = UserProfileViewModel(
            onPressExternalContact: { _ in print("External contact pressed") },
            onPressReport: { print("Report pressed") },
            onPressMessage: { print("Message pressed") },
            onPressShareProfile: { print("Share profile pressed") },
            onPressRemoveFriend: { print("Remove friend pressed") },
            onToggleMute: { print("Mute toggled") },
            onToggleBlock: { print("Block toggled") }
        )
    }
    
    public var body: some View {
        ScrollView {
            VStack (spacing: defaultListSpacing){
                Spacer()
                KikiCellVStack {
                    KikiMiniProfile(
                        title: viewModel.title,
                        subtitle: viewModel.subtitle,
                        note: viewModel.note
                    )
                    Divider()
                    HStack{
                        
                        HStack(spacing: 16.0){
                            KikiButton(
                                text: "Message",
                                mode: .primary
                            ) {
                                viewModel.onPressMessage()
                            }
                            KikiBlob(){
                                Image("add-friend", bundle: .designSystem)                        
                                    .padding(8)
                            }
                        }
                        .padding()
                    }.background(Color.white)
                }
                KikiCellVStack {
                    KikiSettingsCell(
                        icon: Image(systemName: "bell.fill"),
                        title: "Mute",
                        mode: .list,
                        content:  {
                            Toggle("", isOn: $viewModel.isMuted)
                                .labelsHidden()
                        }
                    )
                    Divider()
                    KikiSettingsCell<EmptyView>(
                        icon: Image(systemName: "phone.fill"),
                        title: "+1 (207) 712-5149",
                        mode: .list,
                        onPress: {
                            viewModel.onPressExternalContact(.phone)
                        }
                    )
                    Divider()
                    KikiSettingsCell<EmptyView>(
                        icon: Image(systemName: "video.fill"),
                        title: "FaceTime",
                        mode: .list,
                        onPress: {
                            viewModel.onPressExternalContact(.faceTime)
                        }
                    )
                }
                VStack {
                    KikiSectionTitle(text: "About")
                    KikiBlurb(text: viewModel.bio)
                }
                VStack {
                    KikiSectionTitle(text: "Privacy & Support")
                    KikiCellVStack {
                        KikiSettingsCell(
                            icon: Image(systemName: "nosign"),
                            title: "Block",
                            mode: .list,
                            content: {
                                Toggle("", isOn: $viewModel.isBlocked)
                                    .labelsHidden()
                            }
                        )
                        Divider()
                        KikiSettingsCell<EmptyView>(
                            icon: Image(systemName: "exclamationmark.triangle.fill"),
                            title: "Report",
                            mode: .list,
                            onPress: {
                                viewModel.onPressReport()
                            }
                        )
                    }
                }
                KikiSettingsCell<EmptyView>(
                    title: "Remove Friend",
                    onPress:  {
                        viewModel.onPressRemoveFriend()
                    }
                )
                Spacer()
            }
            .padding()
        }.background(Color.blue)
    }
}

#Preview {
    UserProfile().loadCustomFonts()
}
