import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.chosenAnswers, required this.onRestart,required this.exitQuiz});
  final List<String> chosenAnswers;

  final void Function() onRestart;

  final void Function()exitQuiz;
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i]
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {

    final summaryData =getSummaryData();
    final numTotaQuestions=questions.length;
    final numCorrectQuestions=summaryData.where((data){
      return data['user_answer']==data['correct_answer'];
    }).length;
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text('You answered $numCorrectQuestions out of $numTotaQuestions questions correctly!',
             style: GoogleFonts.ubuntu( 
              color :const Color.fromARGB(255, 230, 200, 253),
              fontSize:20,
              fontWeight:FontWeight.bold,
             ),
             textAlign: TextAlign.center,
             ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(getSummaryData()),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children:[
                TextButton.icon(
                  onPressed: onRestart,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Restart Quiz'),
                ),
                TextButton.icon(
                  onPressed: exitQuiz,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.exit_to_app),
                  label: const Text('EXIT'),
                ),
              ] 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
