import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simba/models/post_model.dart';

class PostService {
  // ----------------------------------
  final CollectionReference<Map<String, dynamic>> postCollection =
      FirebaseFirestore.instance.collection("posts");

  Future<void> savePost(Post post) async {
    return await postCollection.doc(post.id).set(post.toMap());
  }

  Future<void> updatePost(Post post) async {
    try {
      return await postCollection.doc(post.id).update(post.toMap());
    } on FirebaseException catch (e) {
      throw e.message!;
    }
  }

  Post _postFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("post not found");
    // print('data 1');
    // print(data);
    // print('data 2');
    return Post.fromMap(data);
  }

  Stream<Post> post(String id) {
    return postCollection.doc(id).snapshots().map(_postFromSnapshot);
  }

  List<Post> _postListFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _postFromSnapshot(doc);
    }).toList();
  }

  Stream<List<Post>> get posts {
    return postCollection.snapshots().map(_postListFromSnapshot);
  }
}
