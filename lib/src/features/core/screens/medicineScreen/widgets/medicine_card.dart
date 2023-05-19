import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/features/core/screens/medicineScreen/widgets/medicine_label_fields.dart';

class MedicineStockCard extends StatelessWidget {
  const MedicineStockCard({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;

    final isDarkMode = brightness == Brightness.dark;
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mMedicines,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                mInStock,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('MedicineReminder')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading...');
              }

              final data = snapshot.requireData;
              //int medcount = data.docs.length + 1;

              return SingleChildScrollView(
                //scrollDirection: Axis.vertical,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(),
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: data.docs.length,
                      itemBuilder: (BuildContext context, int index) => Column(
                        children: [
                          MedicineLabelFields(
                            medName: '${(data.docs[index]['medName'])}',
                            medStock: '${(data.docs[index]['stock'])}',
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          /*const MedicineLabelFields(medName: 'Medicine 1', medStock: '25'),
          const SizedBox(height: 10),
          const MedicineLabelFields(medName: 'Medicine 2', medStock: '25'),
          const SizedBox(height: 10),
          const MedicineLabelFields(medName: 'Medicine 3', medStock: '25'),
          const SizedBox(height: 10),
          const MedicineLabelFields(medName: 'Medicine 4', medStock: '25'),*/
        ],
      ),
    ));
  }
}
