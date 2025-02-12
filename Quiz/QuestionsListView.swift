import SwiftUI
import Supabase

struct QuestionsListView: View {
    let chapter: Int
    @State private var questions: [Question] = []
    @State private var currentQuestionIndex: Int = 0
    @State private var selectedAnswers: [Int: Set<Int>] = [:]

    var body: some View {
        VStack {
            // Horizontal scrolling question selection buttons
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) { // Increased spacing here
                    ForEach(Array(questions.enumerated()), id: \.offset) { index, _ in
                        Button(action: {
                            currentQuestionIndex = index
                        }) {
                            Text("\(index + 1)")
                                .frame(width: 40, height: 40)
                                .background(currentQuestionIndex == index ? Color.theme.primary : Color.gray.opacity(0.2))
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }

            Divider()

            if !questions.isEmpty, questions.indices.contains(currentQuestionIndex) {
                let selectedQuestion = questions[currentQuestionIndex]

                ScrollView(.vertical, showsIndicators: true) {
                    VStack(alignment: .leading, spacing: 16) {
                        // Question text and pick count
                        VStack(alignment: .leading, spacing: 4) {
                            Text(selectedQuestion.question_data.question)
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Pick \(selectedQuestion.question_data.correct_answers.count).")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal)

                        // Answer options list using actual options
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(selectedQuestion.question_data.options.indices, id: \.self) { index in
                                Button(action: {
                                    toggleAnswer(questionIndex: currentQuestionIndex, optionIndex: index)
                                }) {
                                    VStack(alignment: .leading) { // Wrap HStack in VStack to ensure left alignment
                                        HStack {
                                            // Circle checkbox
                                            Image(systemName: selectedAnswers[currentQuestionIndex, default: []].contains(index) ? "checkmark.circle.fill" : "circle")
                                                .foregroundColor(Color.theme.primary)
                                                .padding(.trailing, 8)

                                            // Option text left aligned with flexible width
                                            Text(selectedQuestion.question_data.options[index])
                                                .multilineTextAlignment(.leading) // Ensures left alignment for multiple lines
                                                .frame(maxWidth: .infinity, alignment: .leading) // Forces left alignment

                                            // Elimination button
                                            Button(action: {
                                                // Toggle elimination logic here
                                            }) {
                                                Image(systemName: "eye")
                                                    .padding(.horizontal, 8)
                                            }
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading) // Ensures the entire row is left-aligned
                                    }
                                    .padding() // Padding inside the button
                                    .background(Color(.systemGray6))
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                                }
                                .foregroundColor(.primary)
                                .padding(.horizontal) // Padding outside the button
                            }
                        }
                        .padding(.top)
                    }
                    .padding(.vertical)
                }
            } else {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
        .navigationTitle("Chapter \(chapter)")
        .task {
            await loadQuestions()
        }
    }

    func toggleAnswer(questionIndex: Int, optionIndex: Int) {
        selectedAnswers[questionIndex, default: []].formSymmetricDifference([optionIndex])
    }

    func loadQuestions() async {
        do {
            questions = try await supabase
                .from("pharmquestions")
                .select("id, question_data")
                .eq("chapter", value: chapter)
                .execute()
                .value
        } catch {
            print("Error loading questions: \(error)")
        }
    }
}

struct QuestionsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuestionsListView(chapter: 1)
        }
    }
}
