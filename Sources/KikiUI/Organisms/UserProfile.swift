//
//  SwiftUIView.swift
//  
//
//  Created by Henry Jones on 11/30/23.
//

import SwiftUI
import DesignSystem

class UserProfileViewModel: ObservableObject {
    @Published var isBlocked: Bool = false
    @Published var isMuted: Bool = false
    @Published var title: String = "Oliver W."
    @Published var subtitle: String = "@Oliver"
    @Published var note: String = "Oliver Wang from your contacts"
    @Published var bio: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."

    func onPressExternalContact(_ contactType: ContactType) {
        switch contactType {
        case .faceTime:
            print("FaceTime tapped")
        case .phone:
            print("Phone tapped")
        }
    }
    
    func onPressReport() {
        print("Report tapped")
    }
    
    func onPressMessage() {
        print("Message tapped")
    }
    
    func onPressRemoveFriend() {
        print("Remove Friend tapped")
    }
}

enum ContactType {
    case faceTime, phone
}

struct UserProfile: View {
    @ObservedObject var viewModel = UserProfileViewModel()
    
    var body: some View {
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
                    KikiButton(
                        text: "Message",
                        mode: .primary
                    ) {
                        viewModel.onPressMessage()
                    }
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
