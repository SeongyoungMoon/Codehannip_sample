/*
This class defines all the possible read/write locations from the Firestore database.
In future, any new path can be added here.
This class work together with FirestoreService and FirestoreDatabase.
 */

class FirestorePath {
  static String concept() => 'Concepts/';
  static String column(documentId) => 'Concepts/${documentId}/Columns';
  static String example() => 'Example/';
  static String users() => 'Users/';
  static String user(String uid) => 'Users/$uid';
  static String project() => 'Projects/';
  static String aProject(String pid) => 'Projects/$pid';
  static String wadiz(String pid) => 'Wadiz/$pid';
}
