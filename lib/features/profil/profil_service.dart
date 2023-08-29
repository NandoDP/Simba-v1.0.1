// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fpdart/fpdart.dart';

// final userProfileControllerProvider =
//     StateNotifierProvider<UserProfileController, bool>(
//   (ref) {
//     final userProfileRepository = ref.watch(userProfileRepositoryProvider);
//     final storageRepository = ref.watch(storageRepositoryProvider);
//     return UserProfileController(
//       userProfileRepository: userProfileRepository,
//       ref: ref,
//       storageRepository: storageRepository,
//     );
//   },
// );

// class UserProfileController extends StateNotifier<bool> {
//   final UserProfileRepository _userProfileRepository;
//   final Ref _ref;
//   final StorageRepository _storageRepository;
//   UserProfileController({
//     required UserProfileRepository userProfileRepository,
//     required Ref ref,
//     required StorageRepository storageRepository,
//   })  : _userProfileRepository = userProfileRepository,
//         _ref = ref,
//         _storageRepository = storageRepository,
//         super(false);

//   void editProfil({
//     required File? profileFile,
//     required BuildContext context,
//     required String name,
//   }) async {
//     state = true;
//     UserM user = _ref.read(userProvider)!;
//     if (profileFile != null) {
//       final res = await _storageRepository.storeFile(
//         path: 'users/profile',
//         id: user.uid,
//         file: profileFile,
//       );
//       res.fold(
//         (l) => showSnackBar(context, l.message),
//         (r) => user = user.copyWith(profilePic: r),
//       );
//     }

//     user = user.copyWith(name: name);
//     final res = await _userProfileRepository.editProfile(user);
//     state = false;
//     res.fold(
//       (l) => showSnackBar(context, l.message),
//       (r) {
//         _ref.read(userProvider.notifier).update((state) => user);
//         Navigator.of(context).pop();
//       },
//     );
//   }
// }

// final userProfileRepositoryProvider = Provider((ref) {
//   return UserProfileRepository(firestore: ref.watch(firestoreProvider));
// });

// class UserProfileRepository {
//   final FirebaseFirestore _firestore;
//   UserProfileRepository({required FirebaseFirestore firestore})
//       : _firestore = firestore;

//   CollectionReference get _users =>
//       _firestore.collection(FirebaseConstants.usersCollection);
//   CollectionReference get _posts =>
//       _firestore.collection(FirebaseConstants.postsCollection);

//   FutureVoid editProfile(UserM user) async {
//     try {
//       return right(_users.doc(user.uid).update(user.toMap()));
//     } on FirebaseException catch (e) {
//       throw e.message!;
//     } catch (e) {
//       return left(Faillure(e.toString()));
//     }
//   }
// }
