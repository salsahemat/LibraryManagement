//
//  MemberListView.swift
//  LibraryManagement
//
//  Created by Nuzulul Salsabila on 23/11/24.
//
import SwiftUI

struct MemberListView: View {
    @ObservedObject var memberViewModel = MemberViewModel()
    @State private var isShowingAddMemberSheet = false
    @State private var memberName: String = "" // State untuk input nama

    var body: some View {
        NavigationView {
            VStack {
                List(memberViewModel.members) { member in
                    HStack {
                        Text(member.name)
                        Spacer()
                        Button(action: {
                            memberViewModel.deleteMember(memberID: member.id)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
                .onAppear {
                    memberViewModel.fetchMembers()
                }

                Button(action: {
                    isShowingAddMemberSheet.toggle()
                }) {
                    Text("Add Member")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .sheet(isPresented: $isShowingAddMemberSheet) {
                    addMemberSheet // Tampilan modal untuk menambah member
                }
            }
            .navigationTitle("Members")
        }
    }

    // View untuk modal sheet
    private var addMemberSheet: some View {
        VStack {
            TextField("Member Name", text: $memberName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Save Member") {
                saveMember()
                isShowingAddMemberSheet = false // Tutup sheet setelah menyimpan
            }
            .padding()
            .disabled(memberName.isEmpty)

            Spacer()
        }
        .padding()
        .presentationDetents([.medium]) // Atur ukuran modal sheet (opsional, iOS 16+)
    }

    // Fungsi untuk menyimpan member baru
    private func saveMember() {
        memberViewModel.addMember(name: memberName)
        memberName = "" // Reset input field setelah menambah member
    }
}
