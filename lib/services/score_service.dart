import 'dart:convert';
import 'package:brick_breaker/config/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreService {

  // load the list of Score objects
  static Future<List<Score>> loadScores() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? scoresJson = prefs.getString('scores');

    if (scoresJson == null) {
      return [];
    }

    final List<dynamic> scoresList = jsonDecode(scoresJson);
    return scoresList.map((json) => Score.fromJson(json)).toList();
  }

  // save the top scores
  static Future<void> saveScore(Score newScore) async {
    List<Score> scores = await loadScores();

    // Add the new score
    scores.add(newScore);

    // Sort scores by highest score first
    scores.sort((a, b) => b.score.compareTo(a.score));

    // Keep only the top required scores
    if (scores.length > AppConfig.scoreCountToSave) {
      scores = scores.sublist(0, AppConfig.scoreCountToSave);
    }

    // Save the updated scores list to SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String scoresJson = jsonEncode(scores.map((score) => score.toJson()).toList());
    await prefs.setString('scores', scoresJson);
  }

}

class Score {
  final int score;
  final String date;
  final int stars;

  Score(this.score, this.date, this.stars);

  // Convert a Score object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'date': date,
      'stars': stars,
    };
  }

  // Create a Score object from a JSON map
  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      json['score'] as int,
      json['date'] as String,
      json['stars'] as int,
    );
  }

  @override
  String toString() {
    return 'Score{score: $score, date: $date, stars:$stars}';
  }
}