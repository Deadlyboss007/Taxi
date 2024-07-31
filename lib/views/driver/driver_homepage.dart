import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:green_taxi/views/decision_screen/decission_screen.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({Key? key}) : super(key: key);

  @override
  State<DriverHomePage> createState() => DriverHomePageState();
}

class DriverHomePageState extends State<DriverHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Home'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('rides').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No rides available'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var ride = snapshot.data!.docs[index];
              var rideData = ride.data() as Map<String, dynamic>;
              var destination =
                  rideData['destination'] as Map<String, dynamic>?;
              var sourceUser = rideData['source'] as Map<String, dynamic>?;

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text('Ride ${ride.id}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Address: ${destination?['address'] ?? 'N/A'}'),
                      Text(
                          'Latitude: ${destination?['latitude']?.toString() ?? 'N/A'}'),
                      Text(
                          'Longitude: ${destination?['longitude']?.toString() ?? 'N/A'}'),
                      Text('Source Address: ${sourceUser?['address'] ?? 'N/A'}'),
                    ],
                  ),
                  trailing: ElevatedButton(
                    child: const Text('Accept'),
                    onPressed: () {
                      // Implement ride acceptance logic here
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _logout() async {
    await _auth.signOut();
    Get.offAll(() => DecisionScreen());
  }
}
