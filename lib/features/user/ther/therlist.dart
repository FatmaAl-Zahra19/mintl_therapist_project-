import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mintl555555555/features/user/ther/allinfobokk.dart';

class TherapistCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Therapist Card'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Therapist_Information').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(), // Display a loading indicator while fetching data
            );
          }
          var therapists = snapshot.data?.docs; // Extract the documents from the snapshot
          return ListView.builder(
            itemCount: therapists?.length,
            itemBuilder: (context, index) {
              var therapist = therapists?[index].data();
              String name = therapist?['name'] ?? 'No Name';
              String specialty = therapist?['specialty'] ?? 'No Specialty';
              String? pp = therapist?['pp']; // Fetch the profile picture URL
              return buildTherapistCard(context, name, specialty, pp);
            },
          );
        },
      ),
    );
  }

  Widget buildTherapistCard(BuildContext context, String name, String specialty, String? pp) {
    late String _name = name;
    late String _specialty = specialty;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TherapistDetailsPage(
              name: _name,
              specialty: _specialty,
              pp: pp,
            ),
          ),
        );
      },
      child: Center(
        child: Container(
          width: 382,
          height: 116,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color(0x33D68FFF),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(right: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF100D10),
                          fontSize: 16,
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.w700,
                          height: 0.09,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'التخصص : $_specialty',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF494649),
                          fontSize: 16,
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.w500,
                          height: 0.09,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 16,
                height: 16,
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    image: pp != null && pp.isNotEmpty
                        ? NetworkImage(pp) as ImageProvider
                        : AssetImage('assets/images/Therapistimage.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
