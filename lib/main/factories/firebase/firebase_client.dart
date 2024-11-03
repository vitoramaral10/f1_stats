import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/firebase/firebase.dart';
import '../../../infra/firebase/firebase.dart';

FirebaseClient makeFirebaseClient() =>
    FirebaseAdapter(firestore: FirebaseFirestore.instance);
